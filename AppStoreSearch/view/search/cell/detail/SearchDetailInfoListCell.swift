//
//  SearchDetailInfoListCell.swift
//  AppStoreSearch
//
//  Created by 조미경 on 27/07/2020.
//

import UIKit

class SearchDetailInfoListCell: UITableViewCell {

    static let CELL_HEIGHT:CGFloat = 40
    
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mValueLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setData(type: SEARCH_DETAIL_INFO_ROW, result: Result) {
        
        // 타이틀
        mTitleLabel.text = type.getTitle()
        
        // 값
        mValueLabel.text = type.getValue(result: result)
    }
}
