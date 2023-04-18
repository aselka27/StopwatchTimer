//
//  MainViewModel.swift
//  StopwatchTimer
//
//  Created by саргашкаева on 13.04.2023.
//

import Foundation

enum Modes {
    case running
    case paused
    case stopped
}

class MainViewModel: ObservableObject {
    
    private var timeModel = Time()
    @Published var mode = Modes.stopped
    @Published var types = ["Stopwatch", "Timer"]
    var hours = [Int](0..<24)
    var minutes = [Int](0..<60)
    var seconds = [Int](0..<60)
    var counter = 0
    var timer = Timer()
    
    func runStopwatch() {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] _ in
            guard let self = self else { return }
            self.counter += 1
            self.timeModel.hoursElapsed = self.counter / 3600
            self.timeModel.minutesElapsed = (self.counter % 3600) / 60
            self.timeModel.secondsElapsed = (self.counter % 3600) % 60
        })
    }
    
    func runTimer() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if  self.timeModel.secondsElapsed == 0 &&  self.timeModel.minutesElapsed != 0 {
                self.timeModel.minutesElapsed -= 1
                self.timeModel.secondsElapsed = 59
            } else if  self.timeModel.minutesElapsed == 0 &&  self.timeModel.hoursElapsed != 0 {
                self.timeModel.hoursElapsed -= 1
                self.timeModel.minutesElapsed = 59
                self.timeModel.secondsElapsed = 59
            } else if  self.timeModel.minutesElapsed == 0 &&  self.timeModel.hoursElapsed == 0 &&  self.timeModel.secondsElapsed == 0 {
                self.timer.invalidate()
            } else {
                self.timeModel.secondsElapsed -= 1
            }
        }
    }
    
    func pauseStopwatch() {
        mode = .paused
        timer.invalidate()
    }
    
    func stopStopwatch() {
        mode = .stopped
        timer.invalidate()
        counter = 0
        self.timeModel.secondsElapsed = 0
        self.timeModel.minutesElapsed = 0
        self.timeModel.hoursElapsed = 0
    }
}

extension MainViewModel {
    var formattedTimeString: String {
        return String(format: "%02i:%02i:%02i",
                      self.timeModel.hoursElapsed,
                      self.timeModel.minutesElapsed,
                      self.timeModel.secondsElapsed)
    }
}
