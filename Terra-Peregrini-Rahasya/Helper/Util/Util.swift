//
//  Util.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import Foundation
import SwiftUI
import Photos

func cardBackgroundColor(endingStatus: EndingStatus?) -> Color {
    return switch endingStatus {
    case .success:
        Color.TPRColor.SuccessGreen
        
    case .failed:
        Color.TPRColor.FailedRed
        
    case .ingame:
        Color.TPRColor.SecondaryPurple
        
    case .none:
        Color.TPRColor.SecondaryPurple
        
    case .defaults:
        Color.TPRColor.PrimaryBlue
    }
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

func processingCapturedImage() {
    
}
