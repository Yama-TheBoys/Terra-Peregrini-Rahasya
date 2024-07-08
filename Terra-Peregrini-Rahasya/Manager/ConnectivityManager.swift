//
//  ConnectivityManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 03/07/24.
//

import MultipeerConnectivity
import HomeKit
import SwiftUI

final class ConnectivityManager: ObservableObject {
    
    var mpcService: MPCService?
    var homeService: HomeService?
    
    @AppStorage("candidateName") private var candidateName = ""
    @AppStorage("teamCode") private var teamCode = ""
    
    @Published var connectedPeers = [MCPeerID]()
    @Published var homes = [HMHome]()
    @Published var rooms = [HMRoom]()
    @Published var selectedHome: HMHome?

    // Onboarding
    @Published var isAssembledDone = false
    @Published var isHostChosen = false
    @Published var isHostCancelled = false
    @Published var isHostSuccess = false
    @Published var isHostStarted = false
    
    // Waiting Room
    @Published var isPlayersReady = false
    @Published var playersQueued = [MCPeerID]()
    
    // For mission manager
    @Published var isAllPlayerCorrectFirstMission = false
    @Published var isSelfCorrectFirstMission = false
    @Published var playersCorrectFirstMission = [MCPeerID : Bool]()
        
    init(mpcService: MPCService? = nil) {
        self.mpcService = mpcService
    }
    
    func getCandidateName() -> String {
        candidateName
    }
    
    // Call this func first
    func startConnecting(name: String, teamCode: String) {
        self.mpcService = MPCService(name: name, teamCode: teamCode)
        self.candidateName = name
        self.teamCode = teamCode
        self.mpcService?.delegate = self
                
        self.mpcService?.startBroadcasting()
    }
    
    func proceedToHomeOnboard() {
        self.mpcService?.sendMessageToPeers(.assembled)
    }
    
    func startSetupHomeAsHost() {
        self.mpcService?.sendMessageToPeers(.setupHome)
    }
    
    func startHomeSetup() {
        self.homeService = HomeService()
        self.homeService?.delegate = self
        print("Home Authorization: ", self.homeService?.checkAuthorization())
    }
    
    func sendMessageToNavigateBack() {
        self.homeService = nil
        self.mpcService?.sendMessageToPeers(.navigateBack)
    }
    
    func selectHomeFromIndex(_ index: Int) {
        selectedHome = homes[index]
        if let rooms = selectedHome?.rooms {
            self.rooms = rooms
        }
    }
    
    func checkRoomAvailabilityFromIndex(_ index: Int, handler: @escaping (Bool, Bool) -> Void) {
        let result = self.homeService?.checkRoomAvailability(room: rooms[index])
        guard let isLampAvailable = result?.0, let isDoorLockAvailable = result?.1 else {
            handler(false, false)
            return
        }
        DispatchQueue.main.async {
            handler(isLampAvailable, isDoorLockAvailable)
        }
    }
    
    func sendMessageSuccessHomeSetup() {
        self.mpcService?.sendMessageToPeers(.successSetupHome)
    }
    
    func sendMessageToStartFirstMission() {
        self.mpcService?.sendMessageToPeers(.startFirstMission)
    }
    
    func sendMessagePlayerQueued() {
        self.mpcService?.sendMessageToPeers(.playerQueued)
    }
    
    func sendMessagePlayerStartMission() {
        DispatchQueue.main.async {
            self.playersQueued.removeAll()
            self.isPlayersReady = false
        }
    }
    
    func sendMessageCorrectFirstMission(correct: Bool) {
        self.isSelfCorrectFirstMission = correct
        self.mpcService?.sendMessageToPeers(correct ? .correctFirtMission : .wrongFirstMission)
    }
    
}

extension ConnectivityManager: MPCServiceDelegate {
    func didReceiveData(_ state: SendState, fromPeer peerId: MCPeerID) {
        switch state {
        case .setupHome:
            DispatchQueue.main.async {
                self.isHostChosen.toggle()
            }
        case .assembled:
            DispatchQueue.main.async {
                self.isAssembledDone.toggle()
            }
        case .navigateBack:
            DispatchQueue.main.async {
                self.isHostCancelled.toggle()
            }
        case .successSetupHome:
            DispatchQueue.main.async {
                self.isHostSuccess.toggle()
            }
        case .startFirstMission:
            DispatchQueue.main.async {
                self.isHostStarted.toggle()
            }
        case .playerQueued:
            DispatchQueue.main.async {
                self.playersQueued.append(peerId)
                if self.playersQueued.count == 4 {
                    self.isPlayersReady.toggle()
                }
            }
        case .correctFirtMission:
            DispatchQueue.main.async {
                self.playersCorrectFirstMission[peerId] = true
                
                if !self.playersCorrectFirstMission.values.contains(where: { $0 == false }),
                    self.isSelfCorrectFirstMission,
                    self.playersCorrectFirstMission.count == 4 {
                    self.isAllPlayerCorrectFirstMission = true
                }
                
            }
        case .wrongFirstMission:
            DispatchQueue.main.async {
                self.playersCorrectFirstMission[peerId] = false
            }
        case .unknown:
            break
        }
    }

    func didConnectedToPeer(_ peer: MCPeerID) {
        DispatchQueue.main.async {
            self.connectedPeers.append(peer)
        }
    }
    
    func didDisconnectedFromPeer(_ peer: MCPeerID) {
        DispatchQueue.main.async {
            self.connectedPeers.removeAll { $0 == peer }
        }
    }
}

extension ConnectivityManager: HomeServiceDelegate {
    func didUpdateHomes(home: [HMHome]) {
        DispatchQueue.main.async {
            self.homes = home
        }
    }
}
