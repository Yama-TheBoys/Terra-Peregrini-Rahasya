//
//  Sound.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 08/07/24.
//

import Foundation
import AVFoundation

var buttonPlayer: AVAudioPlayer!
var openingPlayer: AVAudioPlayer!
var pointPlayer: AVAudioPlayer!

func playSound(key: String, forType type: String) {
    guard let soundURL = Bundle.main.url(forResource: key, withExtension: "wav") else {
        print("Sound file not found for key: \(key)")
        return
    }
    
    do {
        switch type {
        case "point":
            pointPlayer = try AVAudioPlayer(contentsOf: soundURL)
            pointPlayer?.play()
        case "button":
            buttonPlayer = try AVAudioPlayer(contentsOf: soundURL)
            buttonPlayer?.play()
        case "opening":
            if openingPlayer == nil || !openingPlayer.isPlaying {
                openingPlayer = try AVAudioPlayer(contentsOf: soundURL)
                openingPlayer?.play()
            }
        default:
            print("Unknown sound type: \(type)")
        }
    } catch {
        print("Error playing sound: \(error)")
    }
}

func playButtonClickSound() {
    playSound(key: "button-clicked", forType: "button")
}

func playPointEarnedSound() {
    playSound(key: "Point-Earned", forType: "point")
}

func playOpeningSound() {
    playSound(key: "Opening_Dystopian", forType: "opening")
}
