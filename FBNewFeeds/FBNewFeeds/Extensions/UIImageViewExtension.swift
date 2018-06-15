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

    func moveEmojiSelected() {
        let bezierPath = UIBezierPath()
        let toPoint = CGPoint(x: 10, y: frame.origin.y)
        let rangeX = frame.origin.x / 3
        let cp2 = CGPoint(x: frame.origin.x - rangeX, y: frame.origin.y - 100)
        bezierPath.move(to: center)
        bezierPath.addQuadCurve(to: toPoint, controlPoint: cp2)
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.duration = 0.4
        animation.path = bezierPath.cgPath
        animation.fillMode = kCAFillModeForwards
        layer.add(animation, forKey: nil)
    }

    func transformEmojiSelected() {
        let animation = CAKeyframeAnimation(keyPath: "transform.scale")
        animation.values = [1, 0.1]
        animation.duration = 0.4
        layer.add(animation, forKey: "what")
    }

}
