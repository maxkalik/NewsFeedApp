//
//  NewsProvider.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/13/21.
//

import Foundation

public struct NewsProvider {
    
    
    
    static func getNews(complition: @escaping (NewsPost) -> Void) {
        
        let userDefaults = UserDefaults(suiteName: "group.com.maxkalik.NewsFeedApp.Meduza")
        let language = userDefaults?.string(forKey: Settings.languageKey) ?? "en"
        
        NetworkService.shared.fetchNewsFeed(fromPage: 0, perPage: 1, language: language) { result in
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
