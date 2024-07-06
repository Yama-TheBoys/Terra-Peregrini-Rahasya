//
//  HomeNotFoundHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 05/07/24.
//

import SwiftUI

struct HomeNotFoundHostView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Button(action: {
                    router.navigateBack()
                }, label: {
                    ZStack{
                        Image.BackButton
                            .resizable()
                            .scaledToFit()
                            .frame(width: 82)
                        Text("BACK")
                            .customFont(.bold, 16)
                            .foregroundStyle(.white)
                    }
                })
                .padding(.trailing, 280)
                
                Spacer()
                
                CardView(
                    isMission: false,
                    backgroundColor: .failed,
                    title: "ERROR!!!",
                    description: "We didn’t find any home connected to your **HOME APP** or **HOMEKIT**"
                )
                .padding(.top, 28)
                
                Spacer()
                
                Text("The system can’t find any home yet, make sure you have an account with Home registered.")
                    .customFont(.bold, 18)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeNotFoundHostView()
}
