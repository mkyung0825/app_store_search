//
//  SearchDetailScreenShotCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/26.
//

import UIKit

class SearchDetailScreenShotCell: UITableViewCell {
    
    static let TOP_MARGIN:CGFloat = 5
    static let BOTTOM_MARGIN:CGFloat = 20
    
    @IBOutlet weak var mCollectionView: UICollectionView!

    var mScreenShots: [String] = []
    
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
        
        // collection view
        mCollectionView.delegate = self
        mCollectionView.dataSource = self
        
        // collection view > scroll
        mCollectionView.showsHorizontalScrollIndicator = false
        mCollectionView.showsVerticalScrollIndicator = false
        mCollectionView.bounces = false
                
        // collection view > flow layout
        let flowLayout:UICollectionViewFlowLayout = mCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        flowLayout.minimumLineSpacing = 10                  // vertical line spacing
        flowLayout.minimumInteritemSpacing = 0              // spacing between 2 cells
        flowLayout.sectionInset = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
        
        // collection view > reuse cell
        mCollectionView.register(UINib(nibName: "ScreenShotCollectionCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCollectionCell")
        
    }
    
    func setData(screenshots: [String]) {
        mScreenShots = screenshots
        
        mCollectionView.reloadData()
    }
}


// MARK:- CollectionView Delegate
extension SearchDetailScreenShotCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mScreenShots.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCollectionCell", for: indexPath) as! ScreenShotCollectionCell
        cell.setData(url: mScreenShots[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var size:CGSize = Common.getImageSizeWithUrl(url: mScreenShots[indexPath.row])
        
        size.width = size.width / 2
        size.height = size.height / 2
        
//        LOG("screeshot : \(indexPath.row), \(mScreenShots[indexPath.row]) -> \(size)")
        
        return size
    }

}
