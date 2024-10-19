//
//  FrogAppWidgetLiveActivity.swift
//  FrogAppWidget
//
//  Created by William Barr on 10/18/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct FrogAppWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct FrogAppWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: FrogAppWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension FrogAppWidgetAttributes {
    fileprivate static var preview: FrogAppWidgetAttributes {
        FrogAppWidgetAttributes(name: "World")
    }
}

extension FrogAppWidgetAttributes.ContentState {
    fileprivate static var smiley: FrogAppWidgetAttributes.ContentState {
        FrogAppWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: FrogAppWidgetAttributes.ContentState {
         FrogAppWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: FrogAppWidgetAttributes.preview) {
   FrogAppWidgetLiveActivity()
} contentStates: {
    FrogAppWidgetAttributes.ContentState.smiley
    FrogAppWidgetAttributes.ContentState.starEyes
}
