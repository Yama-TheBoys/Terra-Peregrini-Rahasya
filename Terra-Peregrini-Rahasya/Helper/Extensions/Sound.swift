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
var missionPlayer: AVAudioPlayer!
var cluePlayer: AVAudioPlayer!
var endingPlayer: AVAudioPlayer!
var stopPlayer: AVAudioPlayer!

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
        case "mission":
            if openingPlayer?.isPlaying == true {
                openingPlayer.stop()
            }
            if missionPlayer == nil || !missionPlayer.isPlaying {
                missionPlayer = try AVAudioPlayer(contentsOf: soundURL)
                missionPlayer.numberOfLoops = -1
                missionPlayer?.play()
            }
        case "button":
            buttonPlayer = try AVAudioPlayer(contentsOf: soundURL)
            buttonPlayer.volume = 0.1
            buttonPlayer?.play()
        case "clue":
            cluePlayer = try AVAudioPlayer(contentsOf: soundURL)
            cluePlayer.volume = 0.5
            cluePlayer?.play()
        case "opening":
            if missionPlayer?.isPlaying == true {
                missionPlayer.stop()
            }
            if endingPlayer?.isPlaying == true {
                endingPlayer.stop()
            }
            if openingPlayer == nil || !openingPlayer.isPlaying {
                openingPlayer = try AVAudioPlayer(contentsOf: soundURL)
                openingPlayer.numberOfLoops = -1
                openingPlayer?.play()
            }
        case "ending":
            if missionPlayer?.isPlaying == true {
                missionPlayer.stop()
            }
            if endingPlayer == nil || !endingPlayer.isPlaying {
                endingPlayer = try AVAudioPlayer(contentsOf: soundURL)
                endingPlayer?.play()
            }
        case "stop":
            if missionPlayer?.isPlaying == true {
                missionPlayer.stop()
            }
        default:
            print("Unknown sound type: \(type)")
        }
    } catch {
        print("Error playing sound: \(error)")
    }
}

func playButtonClickSound() {
    playSound(key: "Button-Clicked", forType: "button")
}

func playMissionStartSound() {
    playSound(key: "Mission-Start", forType: "mission")
}

func playPointEarnedSound() {
    playSound(key: "Point-Earned", forType: "point")
}

func playClueSound() {
    playSound(key: "Clue-Sound", forType: "clue")
}

func playOpeningSound() {
    playSound(key: "Opening-Sound", forType: "opening")
}

func playEndingSound() {
    playSound(key: "Ending-Sound", forType: "ending")
}

func stopSound() {
    playSound(key: "", forType: "stop")
}
