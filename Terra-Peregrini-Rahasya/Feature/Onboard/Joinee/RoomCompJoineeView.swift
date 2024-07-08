//
//  RoomComptJoineeView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct RoomCompJoineeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    
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
                            .bold()
                            .font(.custom("JetBrainsMono-Regular", size: 16))
                            .foregroundStyle(.white)
                    }
                })
                .padding(.trailing, 280)
                
                Spacer()
                Image.Room
                    .resizable()
                    .scaledToFit()
                    .frame(width: 350)
                
                Spacer()
                
                Text("Waiting for home to be fully setup by the host candidate.")
                    .padding(.horizontal, 24)
                    .multilineTextAlignment(.center)
                    .font(.custom("JetBrainsMono-Regular", size: 18))
                    .foregroundStyle(.white)
                    .bold()
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                
                Spacer()
            }
        }
        .navigationBarBackButtonHidden()
        .onChange(of: connectivityManager.isHostCancelled) {
            if connectivityManager.isHostCancelled {
                router.navigateBack()
            }
        }
        .onChange(of: connectivityManager.isHostSuccess) {
            if connectivityManager.isHostSuccess {
                router.navigate(to: .roomsuccessjoinee)
            }
        }
    }
}

#Preview {
    RoomCompJoineeView()
}
