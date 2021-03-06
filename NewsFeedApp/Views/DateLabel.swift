//
//  DataLabel.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

class DateLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func common() {
        numberOfLines = 1
        textColor =  .gray
        font = UIFont.boldSystemFont(ofSize: 12)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
