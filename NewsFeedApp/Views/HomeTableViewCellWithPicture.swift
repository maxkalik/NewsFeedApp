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
