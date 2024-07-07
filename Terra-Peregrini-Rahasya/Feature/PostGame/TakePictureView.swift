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
    @State var isSuccess = false
    
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
                                cameraModel.takePhoto()
                            }
                        
                        Image("IdCard")
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
            if isSuccess {
                if let photo = photo {
                    let idCardImage = UIImage(named: "IdCard")
                    let combinedImage = photo.overlayWith(image: idCardImage!, at: CGPoint(x: 230, y: 150))
                    
                    if let combinedImage = combinedImage {
                        router.navigate(to: .captured(combinedImage))
                    }
                    
                }
            } else {
                isSuccess = true
            }
        }
    }
}

import UIKit

extension UIImage {
    func overlayWith(image: UIImage, at point: CGPoint) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        draw(in: CGRect(origin: point, size: CGSize(width: self.size.width * 0.6, height: self.size.height * 0.6)))
        image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return combineImageAndText(image: combinedImage!, text: "ANJAR", fontName: "Orbitron-Medium")
    }
    
    func combineImageAndText(image: UIImage, text: String, fontName: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: image.size)
        let img = renderer.image { context in
            // Draw the image
            image.draw(at: CGPoint.zero)

            // Load custom font
            guard let customFont = UIFont(name: fontName, size: 128) else {
                print("Failed to load the custom font.")
                return
            }

            // Define text attributes
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            // Set up shadow for the glowing effect
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowBlurRadius = 10
            shadow.shadowOffset = CGSize.zero

            let attrs: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white,
                .shadow: shadow
            ]

            // Determine the position to draw the text
            let textSize = text.size(withAttributes: attrs)
            let textRect = CGRect(x: (image.size.width - textSize.width) / 2,
                                  y: image.size.height - (image.size.height / 3 ) + (2 * (textSize.height / 3)),
                                  width: textSize.width,
                                  height: textSize.height)

            // Draw the text with shadow for glowing effect
            context.cgContext.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as? UIColor)?.cgColor)
            text.draw(in: textRect, withAttributes: attrs)

            // Draw the text again to make it sharper
            context.cgContext.setShadow(offset: CGSize.zero, blur: 0, color: nil)
            text.draw(in: textRect, withAttributes: attrs)
        }

        return img
    }
}
