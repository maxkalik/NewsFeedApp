//
//  Date.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/7/21.
//

import Foundation

extension Date {
    static func -(recent: Date, previous: Date) -> (month: Int?, day: Int?, hour: Int?, minute: Int?) {
        let day = Calendar.current.dateComponents([.day], from: previous, to: recent).day
        let month = Calendar.current.dateComponents([.month], from: previous, to: recent).month
        let hour = Calendar.current.dateComponents([.hour], from: previous, to: recent).hour
        let minute = Calendar.current.dateComponents([.minute], from: previous, to: recent).minute
        return (month: month, day: day, hour: hour, minute: minute)
    }
}
