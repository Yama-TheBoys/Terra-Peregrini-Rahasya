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
