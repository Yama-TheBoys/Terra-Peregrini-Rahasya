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
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Text("LEADERBOARD")
                    .customFont(.bold, 36)
                    .foregroundStyle(.white)
                    .padding()
                
                Spacer()
                
                ForEach(players, id: \.name) { player in
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
                            .frame(width: 100, height: 90, alignment: .topLeading)
                        
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
                    .offset(x: -15)
                    .background(
                        Image.LeaderboardBg
                            .resizable()
                            .frame(width: 350, height: 78)
                    )
                }
                .font(.customFont(.bold, 18))
                .frame(width: 300, height: 80)
               
                Spacer()
                Spacer()
                
                Button(action: {
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
            }
        }
        
    }
}

#Preview {
    LeaderboardView()
}
