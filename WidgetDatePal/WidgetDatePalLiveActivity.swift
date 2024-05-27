//
//  WidgetDatePalLiveActivity.swift
//  WidgetDatePal
//
//  Created by Afif Alaudin on 27/05/24.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct WidgetDatePalAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct WidgetDatePalLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: WidgetDatePalAttributes.self) { context in
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

extension WidgetDatePalAttributes {
    fileprivate static var preview: WidgetDatePalAttributes {
        WidgetDatePalAttributes(name: "World")
    }
}

extension WidgetDatePalAttributes.ContentState {
    fileprivate static var smiley: WidgetDatePalAttributes.ContentState {
        WidgetDatePalAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: WidgetDatePalAttributes.ContentState {
         WidgetDatePalAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: WidgetDatePalAttributes.preview) {
   WidgetDatePalLiveActivity()
} contentStates: {
    WidgetDatePalAttributes.ContentState.smiley
    WidgetDatePalAttributes.ContentState.starEyes
}
