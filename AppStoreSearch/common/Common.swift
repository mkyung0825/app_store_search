//
//  Common.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class Common: NSObject {
    
    static let recentSearchKey:String = "RECENT_SEARCH_KEYWORD"
    
    
    // MARK: - Recent Search List
    // get
    class func getRecentSearchList() -> [String] {
        return UserDefaultManager.getUserDefault(key: recentSearchKey) ?? []
    }
    
    // set
    class func setRecentSearchList<T>(value: T) {
        UserDefaultManager.setUserDefault(key: recentSearchKey, value: value)
    }
    
}



// MARK: - functions
func LOG(filename: String = #file, line: Int = #line, funcname: String = #function, _ output: String) {
    NSLog("[LOG] \(filename.components(separatedBy: "/").last ?? "") > \(funcname)(\(line)) :: \n\(output)")
}
