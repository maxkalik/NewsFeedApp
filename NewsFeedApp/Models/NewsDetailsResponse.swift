//
//  NewsDetails.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/5/21.
//

import Foundation

struct NewsDetailsResponse: Decodable {
    let root: Root
}

struct Root: Decodable {
    let title: String
    let secondTitle: String?
    let og: Content?
    let datetime: Int
}

struct Content: Decodable {
    let description: String?
    let image: String?
    let url: String
}
