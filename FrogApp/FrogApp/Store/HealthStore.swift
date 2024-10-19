import Foundation
import HealthKit
import Observation

enum HealthError: Error {
    case healthDataNotAvailable
}

@Observable
class HealthStore: ObservableObject {
    var healthStore: HKHealthStore?
    var lastError: Error?
    var strengthWorkoutCount: Int = 0
    var cardioWorkoutCount: Int = 0
    var mobilityWorkoutCount: Int = 0
    
    init() {
        if HKHealthStore.isHealthDataAvailable() {
            healthStore = HKHealthStore()
            print("Health data is available.")
            Task {
                await requestAuthorization()  // Request authorization when initialized
                startWorkoutObserver()         // Start observing for workouts
            }
        } else {
            lastError = HealthError.healthDataNotAvailable
            print("Health data is not available.")
        }
    }
    
    func requestAuthorization() async {
        let workoutType = HKObjectType.workoutType()  // No need for optional binding.
        guard let healthStore = self.healthStore else { return }

        do {
            try await healthStore.requestAuthorization(toShare: [], read: [workoutType])
            print("Authorization requested successfully for workouts.")
        } catch {
            lastError = error
            print("Failed to request authorization: \(error.localizedDescription)")
        }
    }

    private func startWorkoutObserver() {
        guard let healthStore = self.healthStore else { return }

        let workoutType = HKObjectType.workoutType()
        let query = HKObserverQuery(sampleType: workoutType, predicate: nil) { [weak self] _, _, error in
            if let error = error {
                print("Observer error: \(error)")
                self?.lastError = error
                return
            }
            print("New workout detected")  // Log when a workout is detected
            Task { await self?.fetchWorkoutsByType() }  // Update count
        }

        // Execute the observer query
        healthStore.execute(query)

        // Enable background delivery for the workout type
        healthStore.enableBackgroundDelivery(for: workoutType, frequency: .immediate) { success, error in
            if success {
                print("Background delivery enabled successfully.")
            } else {
                print("Failed to enable background delivery: \(String(describing: error))")
            }
        }
    }
    
    private func fetchWorkoutsByType() async {
        guard let healthStore = self.healthStore else { return }

        let workoutType = HKObjectType.workoutType()
        let query = HKSampleQuery(sampleType: workoutType, predicate: nil, limit: 0, sortDescriptors: nil) { [weak self] _, samples, error in
            if let error = error {
                print("Error fetching workouts: \(error)")
                self?.lastError = error
                return
            }

            guard let workouts = samples as? [HKWorkout] else { return }

            // Initialize counts for each category
            var strengthCount = 0
            var cardioCount = 0
            var mobilityCount = 0

            // Categorize the workouts based on their activity type
            for workout in workouts {
                switch workout.workoutActivityType {
                case .traditionalStrengthTraining,
                     .functionalStrengthTraining,
                     .highIntensityIntervalTraining:
                    strengthCount += 1

                case .running, .cycling, .swimming,
                     .walking, .elliptical,
                     .stairClimbing, .crossTraining:
                    cardioCount += 1

                case .yoga, .mindAndBody, .pilates:
                    mobilityCount += 1

                default:
                    print("Uncategorized workout: \(workout.workoutActivityType.rawValue)")
                }
            }

            print("Strength: \(strengthCount), Cardio: \(cardioCount), Mobility: \(mobilityCount)")

            // Update the UI on the main thread
            DispatchQueue.main.async {
                self?.strengthWorkoutCount = strengthCount
                self?.cardioWorkoutCount = cardioCount
                self?.mobilityWorkoutCount = mobilityCount
            }
        }

        healthStore.execute(query)
    }

    private func updateWorkoutCount() async {
        guard let healthStore = self.healthStore else { return }

        let workoutType = HKObjectType.workoutType()
        let query = HKSampleQuery(sampleType: workoutType, predicate: nil, limit: 0, sortDescriptors: nil) { [weak self] _, samples, error in
            if let error = error {
                print("Error fetching workout samples: \(error.localizedDescription)")
                self?.lastError = error
                return
            }
            let count = samples?.count ?? 0
            print("Fetched workout count: \(count)")  // Log the workout count
            DispatchQueue.main.async {
                self?.strengthWorkoutCount = count
                self?.cardioWorkoutCount = count
                self?.mobilityWorkoutCount = count
                print("Workout count updated to: \(count)")
            }
        }
        healthStore.execute(query)
    }
}
