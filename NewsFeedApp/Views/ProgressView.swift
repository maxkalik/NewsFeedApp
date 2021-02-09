//
//  ProgressView.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/9/21.
//

import UIKit

class ProgressView: UIVisualEffectView {
    
    var title: String? {
        didSet {
            label.text = title
        }
    }
    
    let width: CGFloat = 120.0
    let height: CGFloat = 120.0
    
    let activityIndictor: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    let label: UILabel = UILabel()
    let blurEffect = UIBlurEffect(style: .dark)
    let vibrancyView: UIVisualEffectView
    
    init(title: String? = nil) {
        self.title = title
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        
        super.init(effect: blurEffect)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = ""
        vibrancyView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: blurEffect))
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(vibrancyView)
        contentView.addSubview(activityIndictor)
        contentView.addSubview(label)
        
        activityIndictor.startAnimating()
        activityIndictor.hidesWhenStopped = true
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        setupOnSuperView()
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        clipsToBounds = true
    }
    
    private func setupTitle() {
        label.text = title
        label.textAlignment = NSTextAlignment.center
        label.frame = CGRect(x: 10,
                             y: 26,
                             width: width - 20,
                             height: height)
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
    }
    
    private func setupActivityIndicator() {
        activityIndictor.color = .white
        if title != nil {
            let activityIndicatorSize = activityIndictor.frame.size.width
            activityIndictor.frame = CGRect(x: (width - activityIndicatorSize) / 2,
                                            y: 26,
                                            width: activityIndicatorSize,
                                            height: activityIndicatorSize)
            setupTitle()
        } else {
            activityIndictor.center = contentView.center
        }
    }
    
    private func setupOnSuperView() {
        if let superview = self.superview {
            superview.isUserInteractionEnabled = false
           
            frame = CGRect(x: 0,
                                y: 0,
                                width: width,
                                height: height)
            center = superview.center
            vibrancyView.frame = bounds
            
            setupTitle()
            setupActivityIndicator()
        }
    }
    
    func show() {
        isHidden = false
    }
    
    func hide() {
        isHidden = true
    }
}
