//
//  ExtensionManager.swift
//  AppStoreSearch
//
//  Created by AppleRent on 2020/07/25.
//

import UIKit

extension UIView {
    func setCornerRadius(_ cornerRadius:CGFloat? = nil) {
        let radius = (cornerRadius != nil) ? cornerRadius : (frame.height / 2)
        layer.cornerRadius = radius ?? 0
        layer.masksToBounds = false
        clipsToBounds = true
    }
}

extension UIImageView {
    func load(url: String) {
        guard let imageURL = URL(string: url) else { return }
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
