//
//  CapturedView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI

struct CapturedView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                ZStack{
                    Image.Badge
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200)
                        .padding(.bottom, 150)
                        
                    Image.IdCard
                        .resizable()
                        .frame(width: 393, height: 650)
                    
                }
                
                Spacer()
                
                HStack(spacing: 0){
                    Button(action: {
                        router.navigate(to: .takepicture)
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .frame(width: 155, height: 81)
                            Text("Retake")
                                .customFont(.bold, 18)
                                .foregroundStyle(Color.white)
                        }
                    })
                    Button(action: {
                        router.navigate(to: .idcardoverview)
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .frame(width: 155, height: 81)
                                .scaleEffect(x:-1, y: 1)
                            Text("Next")
                                .customFont(.bold, 18)
                                .foregroundStyle(Color.white)
                        }
                    })
                }
                .padding(.bottom, 15)
                
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    CapturedView()
}
