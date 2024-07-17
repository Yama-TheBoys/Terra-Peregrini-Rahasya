//
//  ContentView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI

struct TakePictureView: View {
    @EnvironmentObject var router: Router
    @StateObject private var cameraModel = CameraModel()
    
    @AppStorage("candidateName") private var candidateName = ""
    
    let idCardImage = UIImage(named: "IdCard")
    
    var body: some View {
        ZStack {
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack {
                ZStack {
                    if cameraModel.isAuthorized {
                        CameraPreview(cameraModel: cameraModel)
                            .frame(width: 224, height: 274)
                            .scaledToFit()
                            .frame(width: 200)
                            .padding(.bottom, 150)
                            .onAppear {
                                cameraModel.startSession()
                            }
                        
                        Image(uiImage: idCardImage!)
                            .resizable()
                            .frame(width: 393, height: 650)
                    }
                }
                
                Spacer()
                Button(action: {
                    cameraModel.takePhoto()
                }) {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 70, height: 70)
                        .overlay(
                            Circle()
                                .stroke(Color.black, lineWidth: 2)
                                .frame(width: 65, height: 65)
                        )
                }
                .padding(.bottom, 30)
            }
        }
        .navigationBarBackButtonHidden()
        .onAppear {
            cameraModel.checkCameraPermission()
        }
        .onChange(of: cameraModel.capturedPhoto) { _, photo in
            if let photo = photo {
                let combinedImage = photo.overlayWith(image: idCardImage!, at: CGPoint(x: 230, y: 150), candidateName: candidateName)
                if let combinedImage = combinedImage {
                    router.navigate(to: .captured(combinedImage))
                }
            }
        }
    }
}
