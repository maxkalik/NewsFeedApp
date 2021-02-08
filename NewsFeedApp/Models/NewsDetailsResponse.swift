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
}

struct Content: Decodable {
    let description: String
    let url: String
}
