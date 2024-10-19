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
            Text("Strength Workout Count: \(healthStore.strengthWorkoutCount)")
                .font(.largeTitle)
                .padding()
        }.task {
            await healthStore.requestAuthorization()
        }
        .padding()
        Button("record strength workout") {
            healthStore.strengthWorkoutCount += 1
        }
        VStack {
            Text("Cardio Workout Count: \(healthStore.cardioWorkoutCount)")
                .font(.largeTitle)
                .padding()
        }.task {
            await healthStore.requestAuthorization()
        }
        .padding()
        Button("record cardio workout") {
            healthStore.cardioWorkoutCount += 1
        }
        VStack {
            Text("Mobility Workout Count: \(healthStore.mobilityWorkoutCount)")
                .font(.largeTitle)
                .padding()
        }.task {
            await healthStore.requestAuthorization()
        }
        .padding()
        Button("record mobility workout") {
            healthStore.mobilityWorkoutCount += 1
        }
    }
}

#Preview {
    ContentView()
}
