//
//  FrogAppWidget.swift
//  FrogAppWidget
//
//  Created by William Barr on 10/18/24.
//

import SwiftUI
import WidgetKit

// Mock function to simulate fetching image and number from "GetFrogge" script
func fetchFroggeData() -> (image: UIImage, number: Int) {
    // Replace this with the actual logic to fetch data from "GetFrogge"
    return (UIImage(named: "frogImage")!, Int.random(in: 1...100))
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), image: UIImage(named: "frogImage")!, number: 0)
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        let froggeData = fetchFroggeData()
        let entry = SimpleEntry(date: Date(), image: froggeData.image, number: froggeData.number)
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        var entries: [SimpleEntry] = []

        let currentDate = Date()
        let froggeData = fetchFroggeData()

        // Create a daily entry
        let entryDate = Calendar.current.startOfDay(for: currentDate)
        let entry = SimpleEntry(date: entryDate, image: froggeData.image, number: froggeData.number)
        entries.append(entry)

        // Schedule to update again the next day
        let nextUpdateDate = Calendar.current.date(byAdding: .day, value: 1, to: entryDate)!
        let timeline = Timeline(entries: entries, policy: .after(nextUpdateDate))

        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let image: UIImage
    let number: Int
}

struct FrogAppWidgetEntryView: View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Image(uiImage: entry.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            Text("Number: \(entry.number)")
                .font(.headline)
        }
    }
}

struct FrogAppWidget: Widget {
    let kind: String = "FrogAppWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            FrogAppWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Frog App Widget")
        .description("This widget shows an image and a number fetched from the GetFrogge script.")
    }
}

@main
struct FrogAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        FrogAppWidget()
    }
}
