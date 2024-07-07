//
//  FirstPlaceView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 05/07/24.
//

import SwiftUI

struct FirstPlaceView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                
                ZStack{
                    Image.InfoCard
                        .resizable()
                        .frame(width: 319, height: 452)
                    
                    VStack{
                        Text("YOU’RE OFFICIALLY A DISTINGUISHED TAPERA AGENT")
                            .customFont(.bold, 18)
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                            .padding(.top, 56)
                        
                        Image.Badge
                            .resizable()
                            .scaledToFit()
                            .frame(width: 160)
                        
                        Text("You made it through the chaos. The missions were almost impossible to carry, but you managed to handle it. You've proven your worth and deserve to be our special agents.")
                            .customFont(.regular, 14)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 56)
                            .multilineTextAlignment(.center)
                    }
                    
                }
                
                Spacer()
                
                Text("It’s time to grab your agent ID. Let’s snap a picture.")
                    .customFont(.regular, 18)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 150)
                    )
                    .padding()
                
                Button(action: {
                    router.navigate(to: .takepicture)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Take ID Picture")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    FirstPlaceView()
}
