//
//  MinimumReqView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 02/07/24.
//

import SwiftUI

struct MinimumReqView: View {
    @EnvironmentObject var router: Router

    var body: some View {
        ZStack{
            Image.DisclaimerScreen
                .resizable()
                .ignoresSafeArea()
            
            VStack(alignment: .center){
                Image(systemName: "gamecontroller.fill")
                    .resizable()
                    .frame(width: 103, height: 64)
                    .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                
                Text("MINIMUM REQUIREMENTS")
                    .customFont(.bold, 36)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.white)
                
                VStack(alignment: .leading){
                    HStack{
                        Text("To play this game, ensure you have the following devices installed in your room and connected to your ")
                        + Text("HomeKit").bold()
                        + Text(" or ")
                        + Text("HOME").bold()
                        + Text(" app:")
                    }
                    .font(.customFont(.regular, 18))
                    .padding(.horizontal, 24)
                    .foregroundStyle(Color.white)
                    
                    HStack{
                        Image(systemName: "lightbulb.max.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                        
                        Text("Smart lamp with RGB support")
                            .customFont(.regular, 18)
                            .padding(.horizontal, 12)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 300, alignment: .center)
                    .padding(.top, 24)
                    
                    HStack{
                        Image(systemName: "door.right.hand.closed")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50)
                            .foregroundStyle(Color(red: 0.85, green: 0.95, blue: 0.99))
                        
                        Text("Smart door lock")
                            .customFont(.regular, 18)
                            .padding(.horizontal, 12)
                            .foregroundStyle(Color.white)
                    }
                    .frame(width: 300, alignment: .center)
                    .padding(.top, 16)
                    
                }
                .padding()
                
                Spacer()
                
                Button(action: {
                    router.navigate(to: .missionIntro)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    MinimumReqView()
}
