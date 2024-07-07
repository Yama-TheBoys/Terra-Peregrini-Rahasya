//
//  CameraModel.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 07/07/24.
//

import SwiftUI
import AVFoundation

class CameraModel: NSObject, ObservableObject, AVCapturePhotoCaptureDelegate {
    @Published var capturedPhoto: UIImage? = nil
    @Published var isAuthorized: Bool = false
    var session: AVCaptureSession?
    
    private var output = AVCapturePhotoOutput()
    var previewLayer: AVCaptureVideoPreviewLayer?
    
    override init() {
        super.init()
        checkCameraPermission()
    }
    
    func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            DispatchQueue.main.async {
                self.isAuthorized = true
                self.setupSession()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.isAuthorized = granted
                    if granted {
                        self.setupSession()
                    }
                }
            }
        case .denied, .restricted:
            DispatchQueue.main.async {
                self.isAuthorized = false
            }
        @unknown default:
            DispatchQueue.main.async {
                self.isAuthorized = false
            }
        }
    }
    
    func setupSession() {
        let session = AVCaptureSession()
        session.beginConfiguration()
        
        guard let camera = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) else {
            print("Failed to get the front camera device")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: camera)
            if session.canAddInput(input) {
                session.addInput(input)
            } else {
                print("Failed to add camera input to session")
                session.commitConfiguration()
                return
            }
        } catch {
            print("Failed to create camera input: \(error.localizedDescription)")
            session.commitConfiguration()
            return
        }
        
        if session.canAddOutput(output) {
            session.addOutput(output)
            
            // Configure photo output settings
            if #available(iOS 16.0, *) {
                if let supportedDimensions = camera.activeFormat.supportedMaxPhotoDimensions.first {
                    output.maxPhotoDimensions = supportedDimensions
                } else {
                    print("No supported dimensions found")
                }
            } else {
                output.isHighResolutionCaptureEnabled = true
            }
        } else {
            print("Failed to add photo output to session")
            session.commitConfiguration()
            return
        }
        
        session.commitConfiguration()
        self.session = session
        
        DispatchQueue.global(qos: .background).async {
            session.startRunning()
        }
    }
    
    func takePhoto() {
        let settings = AVCapturePhotoSettings()
        output.capturePhoto(with: settings, delegate: self)
    }
    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let error = error {
            print("Error capturing photo: \(error.localizedDescription)")
            return
        }
        
        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else {
            print("Failed to process photo")
            return
        }
        
        // Flip the image horizontally if needed
        let flippedImage = image.flippedHorizontally()
        
        DispatchQueue.main.async {
            self.capturedPhoto = flippedImage
        }
    }
    
    func getPreviewLayer() -> AVCaptureVideoPreviewLayer? {
        if previewLayer == nil, let session = session {
            previewLayer = AVCaptureVideoPreviewLayer(session: session)
            previewLayer?.videoGravity = .resizeAspectFill
        }
        return previewLayer
    }
}

extension UIImage {
    func flippedHorizontally() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        
        // Move the origin to the middle of the image so we will rotate and scale around the center.
        context.translateBy(x: self.size.width / 2, y: self.size.height / 2)
        
        // Apply a horizontal flip transformation.
        context.scaleBy(x: -1.0, y: 1.0)
        
        // Draw the image into the transformed context.
        self.draw(in: CGRect(x: -self.size.width / 2, y: -self.size.height / 2, width: self.size.width, height: self.size.height))
        
        let flippedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return flippedImage
    }
}
