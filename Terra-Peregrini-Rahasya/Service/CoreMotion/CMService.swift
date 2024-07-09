//
//  CMService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 06/07/24.
//

import CoreMotion
import UIKit

final class CMService {
    
    let cmMotionManager = CMMotionManager()
    var listener: NSObjectProtocol?
    let notificationCenter = NotificationCenter.default
    let queue = OperationQueue()
    var lastAcceleration: CMAcceleration?
    
    var onShakeDetected: (() -> Void)?
    
    func startMotionUpdate(handler: @escaping CMDeviceMotionHandler) {
        guard cmMotionManager.isDeviceMotionAvailable else { return }
        
        cmMotionManager.startDeviceMotionUpdates(to: .main, withHandler: handler)
    }
    
    func endMotion() {
        cmMotionManager.stopDeviceMotionUpdates()
    }
    
    func startListeningShake() {
        listener = notificationCenter.addObserver(forName: UIDevice.deviceDidShakeNotification, object: nil, queue: .main) { [weak self] notification in
            print("device shaken")
            guard let listener = self?.listener else { return }
            self?.notificationCenter.removeObserver(listener)
        }
    }
    
    func startDetection() {
        cmMotionManager.accelerometerUpdateInterval = 0.1
        guard cmMotionManager.isAccelerometerAvailable else { return }
        
        cmMotionManager.startAccelerometerUpdates(to: queue) { [weak self] (data, error) in
            guard let self = self, let data = data else { return }
            
            let acceleration = data.acceleration
            if let lastAcceleration = self.lastAcceleration {
                let deltaX = acceleration.x - lastAcceleration.x
                let deltaY = acceleration.y - lastAcceleration.y
                let deltaZ = acceleration.z - lastAcceleration.z
                
                let magnitude = sqrt(deltaX * deltaX + deltaY * deltaY + deltaZ * deltaZ)
                
                DispatchQueue.main.async {
                    if magnitude > 2.5 { // Adjust the threshold if needed
                        self.onShakeDetected?()
                    }
                }
            }
            
            self.lastAcceleration = acceleration
        }
    }
    
    func stopDetection() {
        cmMotionManager.stopAccelerometerUpdates()
    }
}

extension UIDevice {
    static let deviceDidShakeNotification = Notification.Name(rawValue: "deviceDidShakeNotification")
}

extension UIWindow {
     open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            NotificationCenter.default.post(name: UIDevice.deviceDidShakeNotification, object: nil)
        }
     }
}
