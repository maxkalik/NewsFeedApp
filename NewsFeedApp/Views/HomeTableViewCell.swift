//
//  HomeTableViewCell.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7
        imageView.backgroundColor = .orange
        imageView.clipsToBounds = true
        return imageView
             
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica Neue Condensed Black", size: 24)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Georgia", size: 20)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dateLabel = DateLabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)

        postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19).isActive = true
        postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19).isActive = true
        postImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -5).isActive = true
        
        subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
        
        
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        
    }
}
