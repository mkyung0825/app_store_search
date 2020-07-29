//
//  SearchDetailDescriptionCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/26.
//

import UIKit

class SearchDetailDescriptionCell: UITableViewCell {
    
    @IBOutlet weak var mDescriptionLabel: UILabel!
    
    @IBOutlet weak var mMoreButton: UIButton!
    
    @IBOutlet weak var mArtistLabel: UILabel!
    
    var mProtocol:SearchViewProtocol!
    var mResult:Result!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUI() {
        
        // 더보기 버튼
        mMoreButton.isUserInteractionEnabled = false
    }
    
    func setData(searchProtocol: SearchViewProtocol, result: Result, isExpand: Bool) {
        mProtocol = searchProtocol
        mResult = result
        
        // 디스크립션
        mDescriptionLabel.text = result.description
        
        // 개발자
        mArtistLabel.text = result.artistName
        
        let descHeight:CGFloat = mDescriptionLabel.sizeThatFits(mDescriptionLabel.frame.size).height
        
        // 더보기 버튼
        if result.description.isEmpty || descHeight < 20 {
            mMoreButton.isHidden = true
        } else {
            mMoreButton.isHidden = false
            
            // 릴리즈 노트 확장 여부 체크
            if isExpand {
                mMoreButton.isHidden = true
                mDescriptionLabel.numberOfLines = 0
            } else {
                mMoreButton.isHidden = false
                mDescriptionLabel.numberOfLines = 3
            }
        }
    }
}
