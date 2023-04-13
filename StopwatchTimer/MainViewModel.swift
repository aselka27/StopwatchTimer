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
    @Published var secondsElapsed = 0
    @Published var minutesElapsed = 0
    @Published var hoursElapsed = 0
    @Published var types = ["Stopwatch", "Timer"]
    var counter = 0
    var timer = Timer()
   @Published var mode = Modes.stopped
 
    
    func runStopwatch() {
        mode = .running
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
            self.counter += 1
            self.hoursElapsed = self.counter / 3600
            self.minutesElapsed = (self.counter % 3600) / 60
            self.secondsElapsed = (self.counter % 3600) % 60
        })
    }
    
    func pauseStopwatch() {
        mode = .paused
        timer.invalidate()
    }
    
    func stopStopwatch() {
        mode = .stopped
        timer.invalidate()
        counter = 0
        secondsElapsed = 0
        minutesElapsed = 0
        hoursElapsed = 0
    }
}
