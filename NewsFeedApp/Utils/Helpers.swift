//
//  Helpers.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/4/21.
//

import Foundation

final class Helpers {
    static let shared = Helpers()
    private init() {}
    
    func getDateDifference(from datetime: Int) -> String {
        let epocTime = TimeInterval(datetime)
        let date = Date(timeIntervalSince1970: epocTime)
        let interval = Date() - date;
        guard let months = interval.month, let days = interval.day, let hours = interval.hour, let minutes = interval.minute else { return "" }
        if months > 0 {
            return "\(months) months ago"
        } else if days > 0 {
            return "\(days) days ago"
        } else if hours > 0 {
            return "\(hours) hours ago"
        } else if minutes > 0 {
            return "\(minutes) minutes ago"
        } else {
            return "Just now"
        }
    }
}
