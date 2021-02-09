//
//  Button.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/9/21.
//

import UIKit

class LinkButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        backgroundColor = .systemBlue
        layer.cornerRadius = 8
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
    }
}
