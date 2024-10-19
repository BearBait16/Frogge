//
//  ContentView.swift
//  FrogApp
//
//  Created by William Barr on 10/18/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var healthStore = HealthStore()
    
    var body: some View {
        VStack {
            Text("Workout Count: \(healthStore.workoutCount)")
                .font(.largeTitle)
                .padding()
        }.task {
            await healthStore.requestAuthorization()
        }
        .padding()
        Button("record workout") {
            healthStore.workoutCount += 1
        }
    }
}

#Preview {
    ContentView()
}
