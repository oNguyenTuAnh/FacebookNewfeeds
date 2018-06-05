//
//  UIColorExtension.swift
//  FBNewFeeds
//
//  Created by nguyen.tu.anh on 5/28/18.
//  Copyright © 2018 nguyen.tu.anh. All rights reserved.
//

import UIKit

extension UIImage {

    func imageWithColor(color: UIColor) -> UIImage? {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        image.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }

    static func downloadedFrom(link: String, completion: @escaping (UIImage) -> Void) {
        if let cachedImage = imageCache.object(forKey: link as NSString) {
            completion(cachedImage)
        } else if let url = URL(string: link) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)
                else {
                    return
                }
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
    }

}
