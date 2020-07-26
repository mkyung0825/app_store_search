//
//  ScreenShotCollectionCell.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/26.
//

import UIKit

class ScreenShotCollectionCell: UICollectionViewCell {

    @IBOutlet weak var mImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUI()
    }

    func setUI() {
        mImageView.setCornerRadius(15)
    }
    
    func setData(url: String) {
        mImageView.image = nil
        mImageView.load(url: url)
    }
}
