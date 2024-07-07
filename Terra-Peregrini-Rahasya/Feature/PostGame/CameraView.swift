//
//  CameraView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI
import AVFoundation

//struct CameraView: UIViewControllerRepresentable {
//    class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
//        var parent: CameraView
//        var session: AVCaptureSession?
//        
//        init(parent: CameraView) {
//            self.parent = parent
//            super.init()
//            setupSession()
//        }
//        
//        func setupSession() {
//            let session = AVCaptureSession()
//            session.beginConfiguration()
//            if let device = AVCaptureDevice.default(.builtInWideAngleCamera, for: .video, position: .front) {
//                if let input = try? AVCaptureDeviceInput(device: device), session.canAddInput(input) {
//                    session.addInput(input)
//                }
//            }
//            session.commitConfiguration()
//            self.session = session
//        }
//        
//        func startRunning() {
//            DispatchQueue.global(qos: .background).async {
//                self.session?.startRunning()
//            }
//        }
//        
//        func stopRunning() {
//            session?.stopRunning()
//        }
//    }
//    
//    func makeCoordinator() -> Coordinator {
//        Coordinator(parent: self)
//    }
//    
//    func makeUIViewController(context: Context) -> UIViewController {
//        let viewController = UIViewController()
//        let session = context.coordinator.session!
//        
//        let previewLayer = AVCaptureVideoPreviewLayer(session: session)
//        previewLayer.videoGravity = .resizeAspectFill
//        previewLayer.frame = CGRect(x: 0, y: 0, width: 224, height: 274)
//        
//        viewController.view.layer.addSublayer(previewLayer)
//        context.coordinator.startRunning()
//        
//        return viewController
//    }
//    
//    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
//}

struct CameraPreview: UIViewRepresentable {
    @ObservedObject var cameraModel: CameraModel
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        
        if let previewLayer = cameraModel.getPreviewLayer() {
            previewLayer.frame = view.bounds
            view.layer.addSublayer(previewLayer)
        } else {
            print("Failed to get preview layer")
        }
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if let previewLayer = cameraModel.previewLayer {
            previewLayer.frame = uiView.bounds
        }
    }
}

