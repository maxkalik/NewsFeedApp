//
//  DetailsViewController.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/6/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let postImageView = PostImageView()
    private let imageCache = NSCache<NSString, UIImage>()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let titleLabel = TitleLabel()
    let secondTitleLabel = SecondTitleLabel()
    let dateLabel = DateLabel()
    lazy var linkButton: LinkButton = {
        let button = LinkButton()
        button.setTitle("Go to origin", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    let textLabel = SecondTitleLabel()
    var newsLink: String?
    var selectedLink: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        getDocument(from: selectedLink)
        view = UIView()
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupViews()
    }
    
    @objc private func buttonTapped() {
        guard let urlString = newsLink, let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    private func showContent() {
        titleLabel.isHidden = false
        secondTitleLabel.isHidden = false
        dateLabel.isHidden = false
        textLabel.isHidden = false
        linkButton.isHidden = false
    }
    
    private func updateLabels(with post: Root) {
        titleLabel.text = post.title
        secondTitleLabel.text = post.secondTitle
        dateLabel.text = Helpers.shared.getDateDifference(from: post.datetime)
        textLabel.text = post.og?.description
    }
    
    private func setupPicture(from imageUrlString: String?) {
        if let imgUrlStr = imageUrlString, let imageUrl = URL(string: imgUrlStr) {
            postImageView.load(from: imageUrl, with: imageCache) { data in
                if let image = data {
                    self.imageCache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                }
                self.postImageView.stopSpinnerAnimating()
            }
        }
    }
    
    private func onSuccess(with post: Root) {
        setupPicture(from: post.og?.image)
        DispatchQueue.main.async { [self] in
            newsLink = post.og?.url
            showContent()
            updateLabels(with: post)
        }
    }
    
    private func getDocument(from link: String?) {
        guard let url = link else { return }
        NetworkService.shared.fetchNewsDetails(fromLink: url) { [self] result in
            switch result {
            case .success(let data): onSuccess(with: data.root)
            case .failure(let error):
                simpleAlert(title: "Something went wrong", msg: "Please try again later")
                print(error.localizedDescription)
            }
        }
    }
}
