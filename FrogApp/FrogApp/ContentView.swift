//
//  ContentView.swift
//  FrogApp
//
//  Created by William Barr on 10/18/24.
//

import SwiftUI


let frogFrog = Frog(frogImage: "frog_still", frogGif: "frog_gif")
let treeFrog = Frog(frogImage: "Tree_Frog_Still", frogGif: "tree_gif")
let dartFrog = Frog(frogImage: "jump_frog_still_2-export", frogGif: "dart_gif")



struct ContentView: View {
    
    @StateObject private var healthStore = HealthStore()
    
    var body: some View {
        HStack {
            VStack {
                Image(getImageNameForFrog(for: healthStore.strengthWorkoutCount,frogType: treeFrog))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 75.0, height: 75.0)
                    .padding()
                Text("Strength Workout Count: \(healthStore.strengthWorkoutCount)")
                    .font(.largeTitle)
                    .padding()
            }.task {
                await healthStore.requestAuthorization()
            }
//            .padding()
            VStack {
                Image(getImageNameForFrog(for: healthStore.cardioWorkoutCount,frogType:frogFrog))
                    .resizable()
                    .frame(width: 75, height: 75)
                    .padding()
                Text("Cardio Workout Count: \(healthStore.cardioWorkoutCount)")
                    .font(.largeTitle)
                    .padding()
                Button("increment") {
                    healthStore.cardioWorkoutCount += 1
                }
            }.task {
                await healthStore.requestAuthorization()
            }
//            .padding()
            VStack {
                Image(getImageNameForFrog(for: healthStore.mobilityWorkoutCount,frogType: dartFrog))
                    .frame(width: 75, height: 75)
                    .padding()
                Text("Mobility Workout Count: \(healthStore.mobilityWorkoutCount)")
                    .font(.largeTitle)
                    .padding()
            }.task {
                await healthStore.requestAuthorization()
            }
//            .padding()
        }
    }
    
    //function to update the image when the counters fo up
    func getImageNameForFrog(for count: Int, frogType: Frog) -> String {
        switch count {
        case 0...10:
            return frogType.eggImage //calls egg image
        case 11...20:
            return frogType.tadpoleImage //calls tadpole image
        default:
            return frogType.frogImage //calls frog image
        }
    }
}

#Preview {
    ContentView()
}
