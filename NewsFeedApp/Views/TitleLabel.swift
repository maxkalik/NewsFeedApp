//
//  TitleLabel.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

class TitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        sizeToFit()
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
        // font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        font = UIFont(name: "HelveticaNeue-CondensedBlack", size: 22)
    }
}
