//
//  ContentView.swift
//  Plank
//
//  Created by Arturas Mickiewicz on 11.01.26.
//

import SwiftUI

struct ContentView: View {
    @State private var viewModel = PlankViewModel(duration: 15)
    
    var body: some View {
        VStack(spacing: 50) {
            Text(viewModel.message)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.brandPrimary)
            
            Button {
                viewModel.toggleWorkout()
            } label: {
                Image(systemName: viewModel.iconName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.brandSecondary)
            }
            
                Text(Duration.seconds(viewModel.time).formatted(
                    .time(
                        pattern: .minuteSecond(padMinuteToLength: 2)
                    )
                ))
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.secondary)
            

        }
        .padding()
    }
}

#Preview {
    ContentView()
}
