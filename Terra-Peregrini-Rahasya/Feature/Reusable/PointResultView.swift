//
//  PointResultView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 06/07/24.
//

import SwiftUI

struct PointResultView: View {
    
    var choosenPlayer: String
    
    var isVoting: Bool
    var isFirstBlood: Bool
    var onAction: () -> Void
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.7)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                if isVoting {
                    Text(choosenPlayer.uppercased())
                        .foregroundStyle(.white)
                        .customFont(.bold, 64)
                        .shadow(color: .blue, radius: 15)
                    
                    Text("has been voted to lose points.")
                        .foregroundStyle(.white)
                        .customFont(.bold, 20)
                        .frame(width: UIScreen.main.bounds.size.width * 0.5)
                        .multilineTextAlignment(.center)
                        .shadow(color: .blue, radius: 10)
                        
                    
                    Text("-10 pts")
                        .foregroundStyle(.white)
                        .customFont(.bold, 50)
                        .padding(.top, 20)
                        .shadow(color: .red, radius: 15)
                } else {
                    HStack(alignment: .center, spacing: 5) {
                        Image(systemName: "trophy")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                            .foregroundStyle(.yellow)
                            .shadow(color: .yellow, radius: 15)
                        
                        Text(
                            isFirstBlood ? "+25" : "+10"
                        )
                        .foregroundStyle(.white)
                        .customFont(.bold, 80)
                        .shadow(color: .yellow, radius: 15)
                        .padding(.leading, 16)
                    }
                    .padding(.bottom, 12)
                    
                    Text(
                        isFirstBlood ? "YOU’RE THE FIRST TO GUESS IT RIGHT. KEEP IT UP!" : "WELL DONE. KEEP UP THE GOOD WORK, CANDIDATES!"
                        
                    )
                        .foregroundStyle(.white)
                        .customFont(.bold, 24)
                        .frame(width: UIScreen.main.bounds.size.width * 0.75)
                        .multilineTextAlignment(.center)
                        .shadow(color: .yellow, radius: 10)
                }
                
                Spacer()
                
                Button(action: onAction, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        Text(
                            isVoting ? "See Clues Now" : "Okay"
                        )
                            .foregroundStyle(Color.white)
                            .customFont(.bold, 18)
                    }
                })
                .frame(width: 237, height: 81)
                .offset(y: -15)
            }
        }
    }
}

#Preview {
    PointResultView(choosenPlayer: "Jul", isVoting: false, isFirstBlood: true, onAction: {})
}
