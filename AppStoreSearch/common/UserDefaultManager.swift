//
//  UserDefaultManager.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class UserDefaultManager: NSObject {
    
    // MARK: set
   class func setUserDefault<T>(key: String, value: T) {
       let userDefaults = UserDefaults.standard
       userDefaults.setValue(value, forKey: key)
       userDefaults.synchronize()
   }

   // MARK: get
   class func getUserDefault<T>(key: String) -> T? {
       return UserDefaults.standard.value(forKey: key) as? T
   }

   // MARK: delete
   class func deleteUserDefault(key: String) {
       UserDefaults.standard.removeObject(forKey: key)
   }
       
}
