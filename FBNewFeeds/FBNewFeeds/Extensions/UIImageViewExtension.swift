//
//  UIImageViewExtension.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/31/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {

    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        if let cachedImage = imageCache.object(forKey: link as NSString) {
            image = cachedImage
        } else if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                      let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                      let data = data, error == nil,
                      let image = UIImage(data: data) else {
                    return
                }
                DispatchQueue.main.async {
                    self.image = image
                }
            }.resume()
        }
    }

}
