//
//  SearchResultCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit
import Cosmos

class SearchResultCell: UITableViewCell {
    
    static let CELL_HEIGHT:CGFloat = 340
    
    
    @IBOutlet weak var mIconImageView: UIImageView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitleLabel: UILabel!
    
    @IBOutlet weak var mUserRatingView: CosmosView!
    @IBOutlet weak var mUserRatingLabel: UILabel!
    
    @IBOutlet weak var mOpenButton: UIButton!
    
    @IBOutlet var mScreenShotImagse: [UIImageView]!
    
    
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
        mIconImageView.setCornerRadius(15)
        
        // 별 평점
        mUserRatingView.settings.fillMode = .precise
        
        // 열기 버튼 - corner radius
        mOpenButton.setCornerRadius()
        
        // 스크린샷 - corner radius
        for imgVIew in mScreenShotImagse {
            imgVIew.setCornerRadius(8)
        }
    }
    
    
    func setData(result: Result) {
        mResult = result
        
        // 아이콘
        mIconImageView.load(url: result.artworkUrl512)
        
        // 타이틀
        mTitleLabel.text = result.trackName
        
        // 서브 타이틀
        mSubTitleLabel.text = result.primaryGenreName
        
        // 별 평점
        mUserRatingView.rating = Double(result.averageUserRating)
        
        // 평점 수
        mUserRatingLabel.text = "\(result.userRatingCount)"
        
        // 스크린샷
        for (idx,imgVIew) in mScreenShotImagse.enumerated() {
            if result.screenshotUrls.count > idx
                && !result.screenshotUrls[idx].isEmpty {
                imgVIew.load(url: result.screenshotUrls[idx])
            }
        }
    }
}
