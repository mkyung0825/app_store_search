//
//  RecentSearchFilterCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

class RecentSearchFilterCell: UITableViewCell {
    
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
    
    func setData(text: String, filterText: String) {

        let messageStr = text
        let attrStr = filterText
        let range = (messageStr as NSString).range(of: attrStr, options: .caseInsensitive)
        
        let attributedString = NSMutableAttributedString(string:messageStr)
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: range)
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .regular), range: range)

        mKeywordLabel.attributedText = attributedString
    }
}
