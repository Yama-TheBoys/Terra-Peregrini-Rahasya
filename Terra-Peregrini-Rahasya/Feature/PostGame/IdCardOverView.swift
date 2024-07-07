//
//  IdCardOverVIew.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI
import Photos

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
    
    func saveImageToPhotoLibrary(image: UIImage) {
            // Ensure the image is saved as PNG to preserve transparency
        if let pngData = image.pngData() {
            if let pngImage = UIImage(data: pngData) {
                UIImageWriteToSavedPhotosAlbum(pngImage, nil, nil, nil)
            }
        }
    }
    
    func checkPhotoLibraryPermission(completion: @escaping () -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .authorized:
            // Permission is already granted
            completion()
        case .denied, .restricted:
            // Permission is denied or restricted
            // Handle this case appropriately in your app
            print("Photo Library access denied or restricted.")
        case .notDetermined:
            // Permission has not been requested yet
            PHPhotoLibrary.requestAuthorization { newStatus in
                if newStatus == .authorized {
                    DispatchQueue.main.async {
                        completion()
                    }
                } else {
                    print("Photo Library access denied.")
                }
            }
        case .limited:
            break
        @unknown default:
            // Handle future cases
            print("Unknown authorization status.")
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let customActivity = SaveImageActivity()
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: [customActivity])

        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        // No update needed
    }
}

import UIKit

class SaveImageActivity: UIActivity {
    var image: UIImage?

    override var activityTitle: String? {
        return "Save Image with Transparency"
    }

    override var activityImage: UIImage? {
        return UIImage(systemName: "square.and.arrow.down")
    }

    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType("com.yourapp.saveImage")
    }

    override class var activityCategory: UIActivity.Category {
        return .action
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if item is UIImage {
                return true
            }
        }
        return false
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if let image = item as? UIImage {
                self.image = image
            }
        }
    }

    override func perform() {
        guard let image = image else { return }

        if let pngData = image.pngData() {
            UIImageWriteToSavedPhotosAlbum(UIImage(data: pngData)!, nil, nil, nil)
        }

        activityDidFinish(true)
    }
}

//#Preview {
//    IdCardOverView()
//}
