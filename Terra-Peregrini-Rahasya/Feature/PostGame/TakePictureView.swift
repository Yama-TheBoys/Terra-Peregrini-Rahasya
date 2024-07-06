//
//  ContentView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI

struct TakePictureView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                ZStack{
                    CameraView()
                        .frame(width: 224, height: 274)
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.bottom, 150)
                        
                    Image.IdCard
                        .resizable()
                        .frame(width: 393, height: 650)
                    
                }
                
                Spacer()
                
                Button(action: {
                    router.navigate(to: .captured)
                }, label: {
                    ZStack{
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 78)
                        Circle()
                            .foregroundStyle(.black)
                            .frame(width: 73)
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 68)
                    }
                })
                .padding(.bottom, 15)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TakePictureView()
}
