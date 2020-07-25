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
        
        // https://itunes.apple.com/search?term=\(term)&entity=software
        NetworkManager.sharedInstance.request(queryString: "search?term=\(term)", completion: completion)
    }
    
    class func getITunesSearcDetail(id: Int) {
        // https://itunes.apple.com/lookup?id=\(id)
    }
    
}
