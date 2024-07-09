//
//  LeaderboardView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 05/07/24.
//

import SwiftUI

struct LeaderboardView: View {
    @EnvironmentObject var router: Router
    
    let players: [(rank: String, name: String, points: Int)] = [
        ("1st", "YAMA", 100),
        ("2nd", "JUL", 90),
        ("3rd", "DAFFA", 80),
        ("4th", "ANJAR", 80),
        ("5th", "NIKO", 60),
    ]
    
    @State private var animate = false
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Text("LEADERBOARD")
                    .customFont(.bold, 36)
                    .foregroundStyle(.white)
                    .padding()
                    .opacity(animate ? 1 : 0)
                    .scaleEffect(animate ? 1 : 0.5)
                    .animation(.easeOut(duration: 0.5).delay(0.1), value: animate)
                
                Spacer()
                
                ForEach(players.indices, id: \.self) { index in
                    let player = players[index]
                    HStack{
                        VStack{
                            Text(player.rank.prefix(1))
                                .customFont(.bold, 28)
                                .foregroundStyle(.white)
                            + Text(player.rank.dropFirst(1).prefix(3))
                                .customFont(.bold, 18)
                                .foregroundStyle(.white)
                            Text("RANK")
                                .customFont(.bold, 18)
                                .foregroundStyle(.white)
                        }
                        .padding(.bottom, 10)
                        .frame(width: 100, height: 50)
                        
                        Spacer()
                        
                        Text(player.name)
                            .foregroundStyle(.white)
                            .padding()
                            .frame(width: 150, height: 90, alignment: .topLeading)
                        
                        Spacer()
                        
                        HStack{
                            Image(systemName: "trophy.fill")
                                .foregroundStyle(Color.TPRColor.PrimaryBlue)
                            
                            Spacer()
                            Text("\(player.points)pts")
                                .foregroundStyle(.white)
                            Spacer()
                        }
                        .frame(width: 110, height: 60, alignment: .topLeading)

                    }
                    .offset(x: animate ? 0 : -300)
                    .background(
                        Image.LeaderboardBg
                            .resizable()
                            .frame(width: 425, height: 78)
                    )
                    .animation(.easeOut(duration: 0.5).delay(0.1 * Double(index)), value: animate)
                }
                .font(.customFont(.bold, 18))
                .frame(width: 300, height: 80)
                
                Spacer()
                Spacer()
                
                Button(action: {
                    playButtonClickSound()
                    router.navigate(to: .firstplace)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Next")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .padding()
                .opacity(animate ? 1 : 0)
                .animation(.easeOut(duration: 0.5).delay(0.5), value: animate)
            }
            .onAppear {
                withAnimation {
                    animate = true
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}


#Preview {
    LeaderboardView()
}
