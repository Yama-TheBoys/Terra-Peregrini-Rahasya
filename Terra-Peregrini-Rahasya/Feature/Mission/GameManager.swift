//
//  GameManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 09/07/24.
//

//import Foundation
//import AVFoundation
//import Combine
//
//class GameManager: ObservableObject {
//    @Published var shakeCount: Int = 0
//    @Published var flashlightManager = FlashlightManager()
//    @Published var shakeDetector = ShakeDetector()
//        
//    init() {
//        
//        shakeDetector.onShakeDetected = { [weak self] in
//            self?.handleShake()
//        }
//    }
//    
//    func startGame() {
//        resetGame()
//        flashlightManager.toggleFlashlight(on: true)
//        shakeDetector.startDetection()
//    }
//    
//    func stopGame() {
//        shakeDetector.stopDetection()
//        flashlightManager.toggleFlashlight(on: false)
//    }
//    
//    private func resetGame() {
//        shakeCount = 0
//    }
//    
//    private func handleShake() {
//        shakeCount += 1
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(Int.random(in: 3...12))) {
//            self.turnOffFlashlight()
//        }
//    }
//    
//    private func turnOffFlashlight() {
//        flashlightManager.toggleFlashlight(on: false)
//    }
//}

import Foundation
import AVFoundation
import Combine

class GameManager: ObservableObject {
    @Published var shakeCount: Int = 0
    @Published var flashlightManager = FlashlightManager()
    
    @Published var lampBrightness = 5.0
    
    private var shakeDetector = ShakeDetector()
    
    var isFirstShaking = true
    var isGameFinish = false
        
    init() {
        shakeDetector.onShakeDetected = { [weak self] in
            
            if self!.isFirstShaking && !self!.isGameFinish {
                self!.isFirstShaking = false
                var rand = Int.random(in: 3...10)
                print(rand)
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(rand)) {
                    self!.turnOffFlashlight()
                }
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
        lampBrightness += 0.25
    }
    
    private func turnOffFlashlight() {
        isGameFinish = true
        flashlightManager.toggleFlashlight(on: false)
    }
}
