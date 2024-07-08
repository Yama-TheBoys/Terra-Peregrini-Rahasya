//
//  IdCardOverVIew.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI

struct IdCardOverView: View {
    @EnvironmentObject var router: Router
    @State private var isShareSheetPresented = false
    
    let capturedImage: UIImage
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Image(uiImage: capturedImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 335, height: 551)
                
                Spacer()
                
                Text("Looking sharp, Agent! \n Here’s your ID card.")
                    .customFont(.regular, 18)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 150)
                    )
                
                HStack(spacing: 0){
                    Button(action: {
                        checkPhotoLibraryPermission {
                            isShareSheetPresented = true
                        }
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .frame(width: 155, height: 81)
                            Text("Share")
                                .customFont(.bold, 18)
                                .foregroundStyle(Color.white)
                        }
                    })
                    .sheet(isPresented: $isShareSheetPresented) {
                        ActivityView(activityItems: [capturedImage, "Hehe"])
                    }
                    
                    Button(action: {
                        router.navigate(to: .credits)
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
                .padding()
            }
        }
        .navigationBarBackButtonHidden()
    }
}
