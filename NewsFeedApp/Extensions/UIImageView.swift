//
//  UIImageView.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

extension UIImageView {
    func load(from url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
