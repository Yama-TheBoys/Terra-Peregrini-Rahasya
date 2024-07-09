//
//  ContentView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 09/07/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var gameManager = GameManager()
    
    var names = ["A", "B", "C", "D", "E"]
    
    var body: some View {
        VStack {
            Text("Shake Game")
                .font(.largeTitle)
                .padding()
            
            VStack {
                HStack {
                    Spacer()
                    Text("Shake Count: \(gameManager.shakeCount)")
                }
                .padding()
            }
            
            Button(action: {
                gameManager.startGame()
            }) {
                Text("Start Game")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.bottom)
            
            Button(action: {
                gameManager.stopGame()
            }) {
                Text("Stop Game")
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            
        }
    }
}

#Preview {
    ContentView()
}
