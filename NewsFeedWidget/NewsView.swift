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
        VStack {
          Text(content.title ?? "")
            .font(.custom("HelveticaNeue-CondensedBlack", size: widgetFamily == .systemMedium ? 18 : 14))
            
            // .multilineTextAlignment(.center)
        Text(content.subtitle ?? "")
            .font(.system(size: 10))
            // .multilineTextAlignment(.center)
            // .padding(.top, 5)
            // .padding([.leading, .trailing])
            // .foregroundColor(.white)
        }.padding()
    }
}
