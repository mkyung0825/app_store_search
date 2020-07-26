//
//  RecentSearchCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class RecentSearchCell: UITableViewCell {
    
    static let CELL_HEIGHT:CGFloat = 40
    
    @IBOutlet weak var mKeywordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(text: String) {
        mKeywordLabel.text = text
    }
}
