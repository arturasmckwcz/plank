//
//  PlankViewModel.swift
//  Plank
//
//  Created by Arturas Mickiewicz on 11.01.26.
//

// TODO: add color coding for time
// TODO: add click management

import SwiftUI
import AudioToolbox

@Observable
class PlankViewModel {
    var status: WorkoutStatus = .idle
    var time: TimeInterval
    var duration: TimeInterval
    private var timerTask: Task<Void, Never>? = nil
    
    init(duration: TimeInterval = 60) {
        self.time = duration
        self.duration = duration
    }
    
    enum WorkoutStatus {
        case idle, active, finished
    }
    
    var iconName: String {
        switch status {
        case .idle: return "play.circle"
        case .active: return "stopwatch"
        case .finished: return "checkmark.seal.fill"
        }
    }
    
    var message: String {
        switch status {
        case .idle: return "Are you ready?"
        case .active: return "Happy planking!"
        case .finished: return "Great job!"
        }
    }
    
    func workout () {
        var timeRemaining: TimeInterval = duration
        timerTask = Task {
            while status == .active {
                AudioServicesPlaySystemSound(1105)
                try? await Task.sleep(for: .seconds(1))
                timeRemaining -= 1
                if timeRemaining >= 0 {
                    time = timeRemaining
                } else {
                    time = duration - timeRemaining
                }
            }
        }
    }
    
    func startWorkout() {
        status = .active
        time = duration
        workout()
    }
    
    func stopWorkout() {
        status = .finished
        timerTask?.cancel()
    }
    
    func resetWorkout() {
        status = .idle
        time = duration
    }
    
    func toggleWorkout() {
        switch status {
            case .idle: startWorkout()
            case .active: stopWorkout()
            case .finished: resetWorkout()
        }
    }
}
