//
//  ShakeDetector.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 17/07/24.
//

import Foundation
import CoreMotion
import Combine

class ShakeDetector: ObservableObject {
    private var motionManager: CMMotionManager
    private let queue = OperationQueue()
    private var lastAcceleration: CMAcceleration?
    
    @Published var isShaking: Bool = false
    var onShakeDetected: (() -> Void)?
    
    init() {
        self.motionManager = CMMotionManager()
        
    }
    
    func startDetection() {
        self.motionManager.accelerometerUpdateInterval = 0.1
        guard motionManager.isAccelerometerAvailable else { return }
        
        motionManager.startAccelerometerUpdates(to: queue) { [weak self] (data, error) in
            guard let self = self, let data = data else { return }
            
            let acceleration = data.acceleration
            if let lastAcceleration = self.lastAcceleration {
                let deltaX = acceleration.x - lastAcceleration.x
                let deltaY = acceleration.y - lastAcceleration.y
                let deltaZ = acceleration.z - lastAcceleration.z
                
                let magnitude = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
                
                DispatchQueue.main.async {
                    self.isShaking = magnitude > 2.5 // bisa dibesarin klo mau shakenya kenceng
                    if self.isShaking {
                        self.onShakeDetected?()
                    }
                }
            }
            
            self.lastAcceleration = acceleration
        }
    }
    
    func stopDetection() {
        motionManager.stopAccelerometerUpdates()
    }
}
