//
//  MissionManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 06/07/24.
//

import Foundation

class MissionManager {
    
    let cmService = CMService()
    
    func startFirstMission() {
        cmService.startMotionUpdate { motion, error in
            if let error = error {
                print("Error starting Motion update: \(error.localizedDescription)")
            } else {
                let pitchEqualToZero = motion?.attitude.pitch ?? 0.1 > -0.05 && motion?.attitude.pitch ?? 0.1 < 0.05
                let rollEqualToZero = motion?.attitude.roll ?? 0.1 > -0.05 && motion?.attitude.roll ?? 0.1 < 0.05
                let yawEqualToZero = motion?.attitude.yaw ?? 0.1 > -0.5 && motion?.attitude.yaw ?? 0.1 < 0.5

                if pitchEqualToZero && rollEqualToZero && yawEqualToZero {
                    print("device placed down")
                }
            }
        }
    }
    
    func endFirstMission() {
        cmService.endMotion()
    }
    
    func startThirdMission() {
        cmService.startListeningShake()
    }
}
