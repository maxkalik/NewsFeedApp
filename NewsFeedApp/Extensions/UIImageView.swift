//
//  UIImageView.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

typealias ImageLoadComplition = (_ data: UIImage?) -> Void

extension UIImageView {

    func load(from url: URL, with cache: NSCache<NSString, UIImage>? = nil, complition: ImageLoadComplition? = nil) {
        if let chachedImage = cache?.object(forKey: url.absoluteString as NSString) {
            complition?(nil)
            DispatchQueue.main.async {
                self.image = chachedImage
            }
        } else {
            fetchImage(from: url, complition: complition)
        }
    }
    
    private func fetchImage(from url: URL, complition: ImageLoadComplition? = nil) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                complition?(image)
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}
