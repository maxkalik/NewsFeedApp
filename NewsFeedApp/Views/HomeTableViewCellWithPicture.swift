//
//  HomeTableViewCellWithPicture.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/8/21.
//

import UIKit

class HomeTableViewCellWithPicture: UITableViewCell {
    let postImageView = PostImageView()
    let titleLabel = TitleLabel()
    let subTitleLabel = SecondTitleLabel()
    let dateLabel = DateLabel()
    
    var imageCache = NSCache<NSString, UIImage>()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
        subTitleLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        common()
    }
    
    func common() {
        contentView.addSubview(postImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)

        postImageViewConstraints()
        titleLabelConstraints()
        subTitleLabelConstraints()
        dateLabelConstraints()
        
        selectionStyle = .none
    }
    
    private func postImageViewConstraints() {
        postImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 19).isActive = true
        postImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        postImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -19).isActive = true
        postImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -15).isActive = true
        postImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    private func titleLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: subTitleLabel.topAnchor, constant: -5).isActive = true
    }
    
    private func subTitleLabelConstraints() {
        subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -10).isActive = true
    }
    
    private func dateLabelConstraints() {
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        dateLabel.text = Helpers.shared.getDateDifference(from: post.datetime)
        subTitleLabel.text = post.secondTitle
        
        if let imageUrlString = post.picture?.mobileRetinaUrl, let imageUrl = URL(string: Settings.hostname + imageUrlString) {
            postImageView.load(from: imageUrl, with: imageCache) { [self] data in
                if let image = data {
                    imageCache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                }
                self.postImageView.stopSpinnerAnimating()
            }
        }
    }
}
