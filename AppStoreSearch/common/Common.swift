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
    
    
    
    // MARK: - functions
    // url encoding
    class func stringByAddingPercentEncoding(text: String) -> String {
        var allowed = CharacterSet.alphanumerics
        allowed.insert(charactersIn: "*-._")
        allowed.insert(charactersIn: " ")
        
        var encoded = text.addingPercentEncoding(withAllowedCharacters: allowed)
        encoded = encoded?.replacingOccurrences(of: " ", with: "+")
        return encoded ?? ""
    }
    
    // 소숫점 몇째자리(count) 까지 반올림 -> 문자로 반환
    class func roundFloat(number: CGFloat, count: Int = 0) -> String {
        return String(format: "%.\(count)f", number)
    }
}



// MARK: - functions
func LOG(filename: String = #file, line: Int = #line, funcname: String = #function, _ output: String) {
    NSLog("[LOG] \(filename.components(separatedBy: "/").last ?? "") > \(funcname)(\(line)) :: \n\(output)")
}
