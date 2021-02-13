//
//  NewsFeedWidget.swift
//  NewsFeedWidget
//
//  Created by Maksim Kalik on 2/13/21.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    func getNews(complition: @escaping (DecodedArray<Post>) -> Void) {
        NetworkService.shared.fetchNewsFeed(fromPage: 1, perPage: 5, language: "en") { result in
            switch result {
            case .success(let data):
                complition(data.documents)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        return SimpleEntry(date: Date(), title: "")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        getNews { posts in
            let entry = SimpleEntry(date: Date(), title: posts.first?.title ?? "")
            completion(entry)
        }
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        getNews { posts in
            // Generate a timeline consisting of five entries an hour apart, starting from the current date.
            let currentDate = Date()
            for hourOffset in 0 ..< 5 {
                let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
                let entry = SimpleEntry(date: entryDate, title: posts.first?.title ?? "")
                entries.append(entry)
            }

            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
        }
        
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let title: String
}

struct NewsFeedWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.date, style: .time)
            Text(entry.title)
        }
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
        NewsFeedWidgetEntryView(entry: SimpleEntry(date: Date(), title: "Title"))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
