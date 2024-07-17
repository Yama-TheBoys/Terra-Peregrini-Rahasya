//
//  FlashlightManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 17/07/24.
//

import AVFoundation

class FlashlightManager {
    private let device = AVCaptureDevice.default(for: .video)
    
    func toggleFlashlight(on: Bool) {
        guard let device = device, device.hasTorch else { return }
        
        do {
            try device.lockForConfiguration()
            device.torchMode = on ? .on : .off
            device.unlockForConfiguration()
        } catch {
            print("Torch could not be used")
        }
    }
}
