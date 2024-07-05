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
                
                ZStack{
                    Image.ErrorCard
                        .resizable()
                        .frame(width: 324, height: 279)
                    
                    Text("1237856619")
                        .customFont(.bold, 16)
                        .foregroundStyle(.white)
                        .padding([.top, .trailing], 48)
                        .frame(width: 324, height: 279, alignment: .topTrailing)
                    
                    VStack{
                        Text("ERROR!!!")
                            .customFont(.bold, 24)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 48)
                        
                        Text("We didn’t find any home connected to your **HOME APP** or **HOMEKIT**")
                            .customFont(.regular, 16)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 10)
                    }
                    .padding(.horizontal, 36)
                    .frame(width: 324, height: 279)
                }
                
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
