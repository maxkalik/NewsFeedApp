//
//  NewsProvider.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/13/21.
//

import Foundation

public struct NewsProvider {
    static func getNews(complition: @escaping (DecodedArray<Post>) -> Void) {
        NetworkService.shared.fetchNewsFeed(fromPage: 1, perPage: 5, language: "en") { result in
            switch result {
            case .success(let data):
                complition(data.documents)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
