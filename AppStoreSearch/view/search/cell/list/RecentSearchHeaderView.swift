//
//  RecentSearchHeaderView.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class RecentSearchHeaderView: UITableViewHeaderFooterView {
    
    static let CELL_HEIGHT:CGFloat = 60
    static let CELL_DETAIL_HEIGHT:CGFloat = 55
    
    @IBOutlet weak var mTitleLabel: UILabel!
    
    
    func setData(title: String) {
        mTitleLabel.text = title
    }
}
