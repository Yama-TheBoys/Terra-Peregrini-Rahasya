//
//  ClockView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 08/07/24.
//

import SwiftUI

struct CountdownTimerView: View {
    let initialTime: Int
    
    @State var remainingTime: Int = 0
    @State var timerIsRunning = false

    var body: some View {
        ZStack {
            timerBackground(timerIsRunning: timerIsRunning)
                .opacity(0.8)
                .frame(width: 112, height: 47)
                .shadow(color: timerBackground(timerIsRunning: timerIsRunning).opacity(0.5), radius: 20)
                .blur(radius: 7.5)
            
            Image.Time
                .resizable()
                .renderingMode(.template)
                .foregroundColor(timerBackground(timerIsRunning: timerIsRunning))
                .scaledToFit()
                .frame(width: 112, alignment: .leading)
                .shadow(color: timerBackground(timerIsRunning: timerIsRunning).opacity(0.5), radius: 20)
                .blur(radius: 0.5)
            
            Image(systemName: "clock")
                .resizable()
                .scaledToFit()
                .frame(width: 34.17)
                .scaleEffect(x: -1, y: 1)
                .offset(x: -34, y: -1)
                .foregroundColor(clockColor(timerIsRunning: timerIsRunning))
                
                
            
            Text(timeFormatted)
                .foregroundStyle(Color.white)
                .customFont(.bold, 18)
                .frame(width: 112, alignment: .leading)
                .offset(x: 48)
        }
       
        .onAppear {
            self.remainingTime = self.initialTime
            startTimer()
        }
    }

    var timeFormatted: String {
        let minutes = remainingTime / 60
        let seconds = remainingTime % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func startTimer() {
        guard !timerIsRunning else { return }
        timerIsRunning = true
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.remainingTime > 0 {
                self.remainingTime -= 1
            } else {
                timer.invalidate()
                self.timerIsRunning = false
            }
        }
    }
}

#Preview {
    CountdownTimerView(initialTime: 3)
}
