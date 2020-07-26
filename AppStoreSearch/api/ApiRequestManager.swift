//
//  ApiRequestManager.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class ApiRequestManager: NSObject {
    
    class func getITunesSearchList<M>(text: String, completion: @escaping ApiCompletion<M>) -> Void {
        
        let term = Common.stringByAddingPercentEncoding(text: text)
        
        // https://itunes.apple.com/search?term=\(term)&entity=software&country=kr
        NetworkManager.sharedInstance.request(queryString: "search?term=\(term)&entity=software&country=kr", completion: completion)
    }
    
    class func getITunesSearcDetail<M>(id: Int, completion: @escaping ApiCompletion<M>) -> Void {
        // https://itunes.apple.com/lookup?id=\(id)
        NetworkManager.sharedInstance.request(queryString: "lookup?id=\(id)&country=kr", completion: completion)
    }
    
}
