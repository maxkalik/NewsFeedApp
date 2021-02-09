//
//  DetailsViewController.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/6/21.
//

import UIKit

class DetailsViewController: UIViewController {
    
    // MARK: - Properties
    
    let                         postImageView = PostImageView()
    var imageCache = NSCache<NSString, UIImage>()
    let scrollView = UIScrollView()
    let contentView = UIView()
    let titleLabel = TitleLabel()
    let secondTitleLabel = SecondTitleLabel()
    let dateLabel = DateLabel()
    let textLabel = SecondTitleLabel()
    
    var selectedLink: String?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDocument(from: selectedLink)
    }
    
    override func loadView() {
        view = UIView()
        
        view.backgroundColor = .white
        setupScrollView()
        setupViews()
        // print(Helpers.shared.getDateToday())

    }
    
    
    
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
    
    func setupViews() {
        
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
        // secondTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(dateLabel)
        dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        dateLabel.topAnchor.constraint(equalTo: secondTitleLabel.bottomAnchor, constant: 10).isActive = true
        dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        // dateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        contentView.addSubview(textLabel)
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        textLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 30).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40).isActive = true
    }
    
    
    deinit {
        print("deinit details view controller")
    }
    
    private func getDocument(from link: String?) {
        // print(link)
        guard let url = link else { return }
        NetworkService.shared.fetchNewsDetails(fromLink: url) { [self] result in
            switch result {
            case .success(let data):
                print(data)
                DispatchQueue.main.async {
                    
                    if let imgUrlString = data.root.og?.image, let imageUrl = URL(string: imgUrlString) {
                        
                        postImageView.load(from: imageUrl, with: imageCache) { data in
                            if let image = data {
                                imageCache.setObject(image, forKey: imageUrl.absoluteString as NSString)
                            }
                            self.postImageView.stopSpinnerAnimating()
                        }
                        
                        
                    }
                    
                    titleLabel.text = data.root.title
                    secondTitleLabel.text = data.root.secondTitle
                    dateLabel.text = Helpers.shared.getDateDifference(from: data.root.datetime)
                    textLabel.text = data.root.og?.description
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
