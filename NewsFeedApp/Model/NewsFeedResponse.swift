//
//  MeduzaResponse.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/4/21.
//

import Foundation

struct NewsFeedResponse: Decodable {
    let hasText: Bool?
    let documents: DecodedArray<Document>
    let collection: [String]
}

struct Document: Decodable {
    let url: String
    let title: String
    let secondTitle: String?
    let picture: Picture?
    let layout: String
    let datetime: Int
}

struct Picture: Decodable {
    let mobileUrl: String
    let mobileRetinaUrl: String
}