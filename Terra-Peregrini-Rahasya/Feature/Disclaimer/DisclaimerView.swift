//
//  DisclaimerView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 02/07/24.
//

import SwiftUI

struct DisclaimerView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Image(.dIsclaimerScreen)
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .center){
                Image(systemName: "exclamationmark.triangle.fill")
                    .resizable()
                    .frame(width: 100, height: 92)
                    .foregroundStyle(Color.yellow)
                
                Text("DISCLAIMER!")
                    .customFont(.bold, 36)
                    .foregroundStyle(Color.white)
                
                VStack{
                    HStack{
                        Image(systemName: "play.house.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, alignment: .center)
                            .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                            
                        Text("This app access your home accessories only during active game sessions.")
                            .customFont(.regular, 18)
                            .frame(width: 300, alignment: .topLeading)
                            .padding(.horizontal, 8)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.top, 24)
                    
                    HStack{
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                            .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                        
                        Text("If you feel uncomfortable, close the app to immediately stop all access to your home accessories.")
                            .customFont(.regular, 18)
                            .frame(width: 300, alignment: .topLeading)
                            .padding(.horizontal, 8)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.top, 16)
                    
                    HStack{
                        Image(systemName: "eye.trianglebadge.exclamationmark.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60)
                            .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                        
                        Text("This game includes flashing lights and colors that may cause epileptic seizure.")
                            .customFont(.regular, 18)
                            .frame(width: 300, alignment: .topLeading)
                            .padding(.horizontal, 16)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.top, 16)
                    
                    HStack{
                        Image(systemName: "figure.walk.motion.trianglebadge.exclamationmark")
                            .resizable()
                            .frame(width: 64, height: 50)
                            .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                        
                        Text("Please be cautious while moving around during play.")
                            .customFont(.regular, 18)
                            .frame(width: 300, alignment: .topLeading)
                            .padding(.horizontal, 8)
                            .foregroundStyle(Color.white)
                    }
                    .padding(.top, 16)
                    
                }
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 24, trailing: 0))
                
                Spacer()
                
                Button {
                    router.navigate(to: .minimumreq)
                } label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                }
                Spacer()
            }
        }
    }
}

#Preview {
    DisclaimerView()
}
