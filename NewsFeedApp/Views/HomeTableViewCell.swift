//
//  HomeTableViewCell.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    let titleLabel = TitleLabel()
    let subTitleLabel = SecondTitleLabel()
    let dateLabel = DateLabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        subTitleLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        common()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func common() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(dateLabel)

        titleLabelConstraints()
        subTitleLabelConstraints()
        dateLabelConstraints()
        
        selectionStyle = .none
    }
    
    func configure(with post: Post) {
        titleLabel.text = post.title
        dateLabel.text = Helpers.shared.getDateDifference(from: post.datetime)
        subTitleLabel.text = post.secondTitle
    }
}
