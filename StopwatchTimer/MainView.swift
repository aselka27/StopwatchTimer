//
//  ContentView.swift
//  StopwatchTimer
//
//  Created by саргашкаева on 13.04.2023.
//

import SwiftUI

struct MainView: View {
    
    @State private var isTimer = "Stopwatch"
    @State private var isPlayTapped = false
    @State private var isPauseTapped = false
    @State private var isResetTapped = false
    @State var selectedHour = 0
    @State var selectedMinute = 0
    @State var selectedSecond = 0
    
    @StateObject var viewModel = MainViewModel()
    
    var body: some View {
        VStack(alignment: .center) {
            VStack(spacing: 20) {
                Image(systemName: isTimer == "Stopwatch" ? "stopwatch" : "timer")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(.black)
                Picker("", selection: $isTimer) {
                    ForEach(viewModel.types, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 70)
            }
            Spacer(minLength: 60)
            VStack {
                Text(viewModel.formattedTimeString)
                    .font(.system(size: 60, weight: .bold))
               
                if isTimer == "Timer" && viewModel.mode != .running && viewModel.mode != .paused {
                    Spacer()
                    timePickerView
                }
                Spacer()
                HStack(spacing: 35) {
                    Button {
                        isResetTapped.toggle()
                        isPlayTapped = false
                        isPauseTapped = false
                        viewModel.stopStopwatch()
                    } label: {
                        Image(systemName: isResetTapped ? "stop.circle" : "stop.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                    }
                    Button {
                       
                        viewModel.pauseStopwatch()
                        isPauseTapped.toggle()
                        isResetTapped = false
                        isPlayTapped = false
                    } label: {
                        Image(systemName: isPauseTapped ? "pause.circle" : "pause.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                    }
                    Button {
                        if isTimer == "Stopwatch" {
                            viewModel.runStopwatch()
                        } else {
                            viewModel.runTimer()
                        }
                        isPlayTapped.toggle()
                        isResetTapped = false
                        isPauseTapped = false
                       
                    } label: {
                        Image(systemName: isPlayTapped ? "play.circle" : "play.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                    }

                }
                .padding(.bottom, 40)
            }
            Spacer()
        }
        .padding()
        .background(Color.yellow)
    }

}

extension MainView {
    var timePickerView: some View {
        HStack {
            Picker("", selection: $viewModel.timeModel.hoursElapsed) {
                ForEach(0..<viewModel.hours.count) { index in
                    Text("\(self.viewModel.hours[index])")
                }
            }
            .pickerStyle(.wheel)
            Picker("", selection: $viewModel.timeModel.minutesElapsed) {
                ForEach(0..<viewModel.minutes.count) { index in
                    Text("\(self.viewModel.minutes[index])")
                }
            }
            .pickerStyle(.wheel)
            Picker("", selection: $viewModel.timeModel.secondsElapsed) {
                ForEach(0..<viewModel.seconds.count) { index in
                    Text("\(self.viewModel.seconds[index])")
                }
            }
            .pickerStyle(.wheel)
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
