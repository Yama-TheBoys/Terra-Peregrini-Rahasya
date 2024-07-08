//
//  EmailView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import SwiftUI

struct EmailView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack {
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Spacer()
                Image.Envelope
                    .resizable()
                    .scaledToFit()
                    .frame(width: 219)
                    .padding()
                
                Spacer()
                
                Text("You have 1 new message.")
                    .customFont(.regular, 18)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                    .padding(.bottom, 10)
                
                Button(action: {
                    playButtonClickSound()
                    router.navigate(to: .invitation)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Open Message")
                            .foregroundStyle(Color.white)
                            .customFont(.bold, 18)
                    }
                })
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    EmailView()
}
