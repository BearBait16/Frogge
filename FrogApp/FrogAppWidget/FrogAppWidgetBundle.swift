//
//  FrogAppWidgetBundle.swift
//  FrogAppWidget
//
//  Created by William Barr on 10/18/24.
//

import WidgetKit
import SwiftUI

@main
struct FrogAppWidgetBundle: WidgetBundle {
    var body: some Widget {
        FrogAppWidget()
        FrogAppWidgetControl()
        FrogAppWidgetLiveActivity()
    }
}
