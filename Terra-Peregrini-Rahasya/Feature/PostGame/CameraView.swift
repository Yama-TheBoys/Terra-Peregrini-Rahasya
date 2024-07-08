//
//  CameraView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 06/07/24.
//

import SwiftUI
import AVFoundation

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

