//
//  SearchResultCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit
import Cosmos

class SearchResultCell: UITableViewCell {
    
    static let CELL_HEIGHT:CGFloat = 300
    
    let MAX_ROW:Int = 3
    
    let HORIZONTAL_MARIGIN_COLLECTION_VIEW:CGFloat = 45
    let CELL_SPACING:CGFloat = 5
    
    
    @IBOutlet weak var mIconImageView: UIImageView!
    @IBOutlet weak var mTitleLabel: UILabel!
    @IBOutlet weak var mSubTitleLabel: UILabel!
    
    @IBOutlet weak var mUserRatingView: CosmosView!
    @IBOutlet weak var mUserRatingLabel: UILabel!
    
    @IBOutlet weak var mOpenButton: UIButton!
    
    @IBOutlet weak var mCollectionView: UICollectionView!
    
    @IBOutlet weak var mContentsHeight: NSLayoutConstraint!
    
    
    var mProtocol:SearchViewProtocol!
    var mResult:Result!
    
    var mScreenShots:[String] = []
    
    var mCollectionViewWidth:CGFloat = 0
    
    var mScreenShotItemSize:CGSize = CGSize(width: 0, height: 180)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setUI()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        mContentsHeight.constant = mScreenShotItemSize.height + 60 + 20
    }
    
    func setUI() {
        
        // 아이콘 - corner radius
        mIconImageView.setCornerRadius(15)
        
        // 별 평점
        mUserRatingView.settings.fillMode = .precise
        mUserRatingView.isUserInteractionEnabled = false
        
        // 열기 버튼 - corner radius
        mOpenButton.setCornerRadius()
        
        // 스크린샷 collection view
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        
        // collection view > scroll
        mCollectionView.showsHorizontalScrollIndicator = false
        mCollectionView.showsVerticalScrollIndicator = false
        mCollectionView.bounces = false
                
        // collection view > flow layout
        let flowLayout:UICollectionViewFlowLayout = mCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.minimumLineSpacing = CELL_SPACING        // vertical line spacing
        flowLayout.minimumInteritemSpacing = 0              // spacing between 2 cells
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        
        // collection view > reuse cell
        mCollectionView.register(UINib(nibName: "ScreenShotCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCollectionCell")
        
        // collection view width
        let screenWidth:CGFloat = UIScreen.main.bounds.width
        mCollectionViewWidth = screenWidth - HORIZONTAL_MARIGIN_COLLECTION_VIEW * 2
    }
    
    
    func setData(searchProtocol: SearchViewProtocol, result: Result) {
        mProtocol = searchProtocol
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
        mUserRatingLabel.text = result.userRatingCount > 0 ? Common.kmFormatStr(value: result.userRatingCount) : ""
        
        // 스크린샷 3개까지
        if mResult.screenshotUrls.count > MAX_ROW {
            mScreenShots = Array(mResult.screenshotUrls[0...MAX_ROW-1])
        } else {
            mScreenShots = mResult.screenshotUrls
        }
        
        mCollectionView.reloadData()
    }
    
    // 열기 버튼 이벤트
    @IBAction func openBtnClickEvent(_ sender: UIButton) {
        mProtocol?.openClick(id: mResult.trackId)
    }
}




// MARK:- CollectionView Delegate
extension SearchResultCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    // row
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mScreenShots.count
    }
    
    // cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCollectionCell", for: indexPath) as! ScreenShotCollectionCell
        cell.setData(url: mScreenShots[indexPath.row], radius: 8)
        return cell
    }
    
    // size
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size:CGSize = Common.getImageSizeWithUrl(url: mScreenShots[indexPath.row])
        var newSize:CGSize = size
        var cellWidth = mCollectionViewWidth
        
        if size.width < size.height {   // 세로형
            // MAX_ROW 개 까지 표시하기 위해 width 계산
            cellWidth = (mCollectionViewWidth / CGFloat(MAX_ROW)) - (CGFloat(MAX_ROW - 1) * CELL_SPACING)
        } else {    // 가로형
            // 이미지 비율 맞춰 노출 (가로 크기 : collection view width)
        }

        newSize = Common.resize(size: size, maxWidth: cellWidth)
        mScreenShotItemSize = newSize
        
        setNeedsLayout()
        layoutIfNeeded()

        return newSize
    }

}
