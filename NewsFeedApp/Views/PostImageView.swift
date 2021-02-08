//
//  PostImageView.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

class PostImageView: UIImageView {
    
    lazy var spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }()
    
    override init(image: UIImage?) {
        super.init(image: image)
        common()
    }
    
    override init(image: UIImage?, highlightedImage: UIImage?) {
        super.init(image: image, highlightedImage: highlightedImage)
        common()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setSpinnerConstraints() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopSpinnerAnimating() {
        DispatchQueue.main.async {
            self.spinner.stopAnimating()
        }
    }
    
    private func common() {
        addSubview(spinner)
        setSpinnerConstraints()
        spinner.startAnimating()
        
        sizeToFit()
        contentMode = .scaleAspectFill
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 7
        clipsToBounds = true
    }
}
