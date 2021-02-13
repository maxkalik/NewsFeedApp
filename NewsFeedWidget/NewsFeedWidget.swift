//
//  NewsFeedWidget.swift
//  NewsFeedWidget
//
//  Created by Maksim Kalik on 2/13/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), newsPost: NewsPost(title: "Fetching...", subtitle: nil, imageUrl: nil))
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        NewsProvider.getNews { post in
            let entry = SimpleEntry(date: Date(), newsPost: post)
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        NewsProvider.getNews { post in
            // Generate a timeline consisting of five entries an hour apart, starting from the current date.
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, newsPost: post)
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
        
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let newsPost: NewsPost
}

struct NewsFeedWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        NewsView(content: entry.newsPost)
    }
}

@main
struct NewsFeedWidget: Widget {
    let kind: String = "NewsFeedWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            NewsFeedWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
    }
}

struct NewsFeedWidget_Previews: PreviewProvider {
    static var previews: some View {
        let newsPost = NewsPost(title: "Russia's censorship agency orders Meduza to delete article about the official reaction to planned pro-Navalny demonstration", subtitle: nil, imageUrl: nil)
        Group {
            NewsFeedWidgetEntryView(entry: SimpleEntry(date: Date(), newsPost: newsPost))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            NewsFeedWidgetEntryView(entry: SimpleEntry(date: Date(), newsPost: newsPost))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
        }
    }
}
