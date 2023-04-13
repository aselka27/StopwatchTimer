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
                .onChange(of: isTimer, perform: { newValue in
                    
                })
                .padding(.horizontal, 70)
            }
            Spacer(minLength: 60)
            VStack {
                Text(String(format: "%02i:%02i:%02i", viewModel.hoursElapsed, viewModel.minutesElapsed, viewModel.secondsElapsed))
                    .font(.system(size: 60, weight: .bold))
                Spacer()
                
               
                HStack(spacing: 35) {
                    Button {
                        isResetTapped.toggle()
                        isPlayTapped.toggle()
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
                        isPlayTapped.toggle()
                    } label: {
                        Image(systemName: isPauseTapped ? "pause.circle" : "pause.circle.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 60, height: 60)
                    }
                    Button {
                        isPlayTapped.toggle()
                        isResetTapped = false
                        isPauseTapped = false
                        viewModel.runStopwatch()
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
        .background(.yellow)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
