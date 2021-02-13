//
//  NewsProvider.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/13/21.
//

import Foundation

public struct NewsProvider {
    static func getNews(complition: @escaping (NewsPost) -> Void) {
        NetworkService.shared.fetchNewsFeed(fromPage: 0, perPage: 1, language: "ru") { result in
            switch result {
            case .success(let data):
                let post = data.documents.last
                complition(NewsPost(title: post?.title, subtitle: post?.secondTitle, imageUrl: post?.picture?.mobileUrl))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}

struct NewsPost {
    let title: String?
    let subtitle: String?
    let imageUrl: String?
}
