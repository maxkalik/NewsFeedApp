//
//  NewsView.swift
//  NewsFeedApp
//
//  Created by Maksim Kalik on 2/13/21.
//

import SwiftUI

struct NewsView: View {
    
    let content: NewsPost
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(content.title ?? "")
                .font(.custom("HelveticaNeue-CondensedBlack", size: widgetFamily == .systemMedium ? 18 : 14))
            Text(content.subtitle ?? "")
                .font(.custom("Georgia", size: widgetFamily == .systemMedium ? 14 : 12))
        }.padding()
    }
}
