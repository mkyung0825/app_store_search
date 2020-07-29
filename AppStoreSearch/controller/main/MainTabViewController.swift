//
//  MainTabViewController.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        moveTab()
    }
    
    // 검색 탭 이동
    func moveTab() {
        selectedIndex = 4
    }

}
