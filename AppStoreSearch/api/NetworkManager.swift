//
//  NetworkManager.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

enum HttpMethod: String{
    case GET = "GET"
}

let ApiBaseURL : String = "https://itunes.apple.com/"

class NetworkManager {
    
    static let sharedInstance = NetworkManager()

    lazy var defaultSession:URLSession = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type" : "application/json"]
        return URLSession(configuration: config, delegate: nil, delegateQueue: nil)
        
    }()
    
    func request<M>(httpMethod: HttpMethod = .GET, queryString: String = "", param: [String:String]? = nil,
                    completion: @escaping ApiCompletion<M>) -> Void {
        
        let url = URL(string:"\(ApiBaseURL)\(queryString)")!
        var request = URLRequest(url: url)
        
//        LOG("api url : \("\(ApiBaseURL)\(queryString)")")

        request.httpMethod = httpMethod.rawValue

        let task = defaultSession.dataTask(with: request) {
            data, response, error in

//            LOG("=================================")
//            LOG("data" + String(describing: data))
//            LOG("response" + String(describing: response))
//            LOG("error" + String(describing: error))
//            LOG("=================================")
            
            if let data = data {
                do {
                    let model:ApiResponse<M> = try JSONDecoder().decode(ApiResponse<M>.self, from: data)
                    
                    if let value = model.results {
                        completion(.apiSuccess(value))

                    } else if let errorMsg = model.errorMessage {
                        let apiError = ApiError(errorMsg)
                        completion(.apiFail(apiError))

                    } else {

                    }
                    
                } catch let error as NSError {
//                    LOG("error : \(error)")
                    completion(.apiFail(ApiError(error)))
                }
                
            } else if let error = error {
//                LOG("error : \(error)")
                completion(.apiFail(ApiError(error as NSError)))
            }
        }
        task.resume()
    }
}
