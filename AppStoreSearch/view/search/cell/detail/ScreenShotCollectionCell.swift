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
        
        // image view - corner radius
        mImageView.setCornerRadius(15)
        
        // image view - border
        mImageView.layer.borderWidth = 1
        mImageView.layer.borderColor = #colorLiteral(red: 0.862745098, green: 0.862745098, blue: 0.862745098, alpha: 1).cgColor        
    }
    
    func setData(url: String, radius: CGFloat = 15) {
        mImageView.setCornerRadius(radius)
        mImageView.image = nil
        mImageView.load(url: url)
    }
}
