//
//  DetailsViewController+Constraints.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/9/21.
//

import UIKit

extension DetailsViewController {
    func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupLabels() {
        titleLabel.isHidden = true
        secondTitleLabel.isHidden = true
        dateLabel.isHidden = true
        textLabel.isHidden = true
    }
    
    func setupViews() {
        setupLabels()
        
        contentView.addSubview(postImageView)
        postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        contentView.addSubview(titleLabel)
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.topAnchor.constraint(equalTo: postImageView.bottomAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        contentView.addSubview(secondTitleLabel)
        secondTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        secondTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        secondTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        contentView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        contentView.addSubview(textLabel)
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        contentView.addSubview(linkButton)
        linkButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        linkButton.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 30).isActive = true
        linkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        linkButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
        linkButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
