//
//  SearchDetailAppInfoCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/26.
//

import UIKit
import Cosmos

class SearchDetailAppInfoCell: UITableViewCell {
    
    static let CELL_HEIGHT:CGFloat = 220
    
    @IBOutlet weak var mIconImageView: UIImageView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitleLabel: UILabel!
    
    @IBOutlet weak var mUserRatingCountLabel: UILabel!
    @IBOutlet weak var mUserRatingView: CosmosView!
    @IBOutlet weak var mUserRatingLabel: UILabel!
    
    @IBOutlet weak var mOpenButton: UIButton!
    @IBOutlet weak var mRightButton: UIButton!
    
    @IBOutlet weak var mTrackContentRating: UILabel!
    
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
        // 아이콘 - corner radius
        mIconImageView.setCornerRadius(20)
        
        // 별 평점
        mUserRatingView.settings.fillMode = .precise
        mUserRatingView.isUserInteractionEnabled = false
        
        // 버튼 - corner radius
        mOpenButton.setCornerRadius()
        mRightButton.setCornerRadius()
        
    }
    
    func setData(searchProtocol: SearchViewProtocol, result: Result) {
        mProtocol = searchProtocol
        mResult = result
        
        // 아이콘
        mIconImageView.load(url: result.artworkUrl512)
        
        // 타이틀
        mTitleLabel.text = result.trackName
        
        // 서브 타이틀
        mSubTitleLabel.text = result.artistName
        
        // 별 평점
        mUserRatingView.rating = Double(result.averageUserRating)
        mUserRatingCountLabel.text = result.averageUserRating > 0 ? Common.roundFloat(number: result.averageUserRating, count: 1) : ""
        
        
        // 평점 수
        mUserRatingLabel.text = result.userRatingCount > 0 ? "\(result.userRatingCount)개의 평가" : "평가 없음"
        
        // 연령
        mTrackContentRating.text = result.trackContentRating
    }
}
