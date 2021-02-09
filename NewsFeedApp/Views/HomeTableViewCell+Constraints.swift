//
//  HomeTableViewCell+Constraints.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/9/21.
//

import UIKit

extension HomeTableViewCell {
    func titleLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -5).isActive = true
    }
    
    func subTitleLabelConstraints() {
        subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
    }
    
    func dateLabelConstraints() {
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }
}
