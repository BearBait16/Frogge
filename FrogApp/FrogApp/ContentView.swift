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
        ZStack {
                    // Background Image
                    Image("background_image_2") // Replace with your image's name
                        .resizable()
                        .scaledToFill() // Ensures the image fills the entire screen
                        .edgesIgnoringSafeArea(.all) // Makes sure it covers the whole view
            VStack {
                Spacer()
                Image("lily_pad")
                    .resizable()
                    .frame(height: 400.0)
                    .offset(y: 150)
            }
                
                
                
            VStack {
                Spacer()
                HStack {
                    VStack {
                        Image(getImageNameForFrog(for: healthStore.strengthWorkoutCount,frogType: treeFrog))
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75.0, height: 75.0)
                            .padding()
                        Text("Strength")
                            .font(.footnote)
                            .foregroundColor(Color.white)
                        Text("\(healthStore.strengthWorkoutCount)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
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
                        Text("Cardio")
                            .foregroundColor(Color.white)
                            .font(.footnote)
                        Text("\(healthStore.cardioWorkoutCount)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                        //                Button("increment") {
                        //                    healthStore.cardioWorkoutCount += 1
                        //                }
                    }.task {
                        await healthStore.requestAuthorization()
                    }
                    //            .padding()
                    VStack {
                        Image(getImageNameForFrog(for: healthStore.mobilityWorkoutCount,frogType: dartFrog))
                            .resizable()
                            .frame(width: 75, height: 75)
                            .padding()
                        Text("Mobility")
                            .foregroundColor(Color.white)
                            .font(.footnote)
                        
                        Text("\(healthStore.mobilityWorkoutCount)")
                            .foregroundColor(Color.white)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .padding()
                    }.task {
                        await healthStore.requestAuthorization()
                    }
                    //            .padding()
                }
                
            }
            
        }
    }
    
    //function to update the image when the counters fo up
    func getImageNameForFrog(for count: Int, frogType: Frog) -> String {
        switch count {
        case 0...9:
            return frogType.eggImage //calls egg image
        case 10...19:
            return frogType.tadpoleImage //calls tadpole image
        default:
            return frogType.frogImage //calls frog image
        }
    }
}

#Preview {
    ContentView()
}
