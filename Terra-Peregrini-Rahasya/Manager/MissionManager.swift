//
//  MissionManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 06/07/24.
//

import Foundation

class MissionManager: ObservableObject {
    
    @Published var playerPoints = 10
    @Published var isFirstMissionDone = false
    @Published var doneTimeStamp: TimeInterval?
    
    @Published var shakeCount: Int = 0
    @Published var flashlightManager = FlashlightManager()
    
    @Published var lampBrightness = 0.25
    
    private var shakeDetector = ShakeDetector()
    
    var isFirstShaking = true
    var isGameFinish = false
    
    private var sessionTimer: Timer?
    private var sessionDuration: TimeInterval = 10
    
    var condition: () -> Bool = { false }
    
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
                    DispatchQueue.main.async {
                        self.isFirstMissionDone = true
                        if self.doneTimeStamp == nil {
                            self.doneTimeStamp = Date.now.timeIntervalSince1970
                        }
                    }
                } else {
                    print("device not in right position")
                    DispatchQueue.main.async {
                        self.isFirstMissionDone = false
                    }
                }
            }
        }
    }
    
    func endFirstMission() {
        self.doneTimeStamp = nil
        cmService.endMotion()
    }
    
    func startThirdMission() {
        detectShaking()
        condition = { self.lampBrightness <= 1 }
        
        startSession()
    }
    
    func detectShaking() {
        shakeDetector.onShakeDetected = { [weak self] in
            
            if self!.isFirstShaking && !self!.isGameFinish {
                self!.isFirstShaking = false
            } else if !self!.isFirstShaking && self!.isGameFinish {
                self!.stopGame()
            }
            
            self?.handleShake()
        }
    }
    
    func startGame() {
        resetGame()
        flashlightManager.toggleFlashlight(on: true)
        shakeDetector.startDetection()
    }
    
    func stopGame() {
        shakeDetector.stopDetection()
        flashlightManager.toggleFlashlight(on: false)
    }
    
    private func resetGame() {
        isGameFinish = false
        isFirstShaking = true
        shakeCount = 0
    }
    
    private func handleShake() {
        shakeCount += 1
        lampBrightness += 0.0025
        print("Lamp Brightness: \(lampBrightness)")
    }
    
    private func turnOffFlashlight() {
        isGameFinish = true
        flashlightManager.toggleFlashlight(on: false)
    }
    
    private func startSession() {
        startGame()
        var times = Int.random(in: 3...10)
        sessionDuration = TimeInterval(times)
        
        print(times)
        
        sessionTimer = Timer.scheduledTimer(withTimeInterval: sessionDuration, repeats: false) { [weak self] _ in
            self?.endSession()
        }
    }
    
    private func endSession() {
        turnOffFlashlight()
        
        //TODO: Simulasi Ganti Orang
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.condition() {
                self.startSession()
            } else {
                self.stopGame()
            }
        }
        
    }
}
