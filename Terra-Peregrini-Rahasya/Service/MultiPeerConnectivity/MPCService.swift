//
//  MPCService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 27/06/24.
//

import MultipeerConnectivity

enum SendState: String {
    case assembled = "assembled"
    case setupHome = "setup-home"
    case navigateBack = "navigate-back"
    case successSetupHome = "success-setup-home"
    case startFirstMission = "start-first-mission"
    case playerQueued = "player-queue"
    case unknown
}

protocol MPCServiceDelegate: AnyObject {
    func didReceiveData(_ state: SendState, fromPeer peerId: MCPeerID)
    func didConnectedToPeer(_ peer: MCPeerID)
    func didDisconnectedFromPeer(_ peer: MCPeerID)
}

final class MPCService: NSObject {
    
    let serviceType = "device-peer"
    let peerSession: MCSession
    let browserSession: MCNearbyServiceBrowser
    let advertiserSession: MCNearbyServiceAdvertiser
    let maxNumberPeers = 4
    
    weak var delegate: MPCServiceDelegate?
    
    var confirmationFromPeers = [MCPeerID]()
    
    init(name: String, teamCode: String) {
        let peerId = MCPeerID(displayName: name)
        
        self.peerSession = MCSession(peer: peerId)
        self.browserSession = MCNearbyServiceBrowser(peer: peerId, serviceType: serviceType)
        self.advertiserSession = MCNearbyServiceAdvertiser(peer: peerId,
                                                           discoveryInfo: ["team_code" : teamCode, "timestamp": String(Date().timeIntervalSince1970)],
                                                           serviceType: serviceType)
        super.init()
        
        self.peerSession.delegate = self
        self.browserSession.delegate = self
        self.advertiserSession.delegate = self
    }
    
    func startBroadcasting() {
        self.browserSession.startBrowsingForPeers()
        self.advertiserSession.startAdvertisingPeer()
    }
    
    private func stopBroadcasting() {
        self.browserSession.stopBrowsingForPeers()
        self.advertiserSession.stopAdvertisingPeer()
    }
    
    func sendMessageToPeers(_ message: SendState) {
        do {
            let data = message.rawValue.data(using: .utf8)!
            try peerSession.send(data, toPeers: peerSession.connectedPeers, with: .reliable)
        } catch(let error) {
            print("Error sendMessageSetupHomeToPeers: \(error.localizedDescription)")
        }
    }
    
    func peerConnected(peerId: MCPeerID) {
        delegate?.didConnectedToPeer(peerId)
        
        let isRoomFull = peerSession.connectedPeers.count == maxNumberPeers
        if isRoomFull {
            self.stopBroadcasting()
        }
    }
    
    func peerDisconnected(peerId: MCPeerID) {
        delegate?.didDisconnectedFromPeer(peerId)
        
        self.startBroadcasting()
    }
    
    func peerDidShareMessage(_ data: Data, from peer: MCPeerID) {
        if let message = String(data: data, encoding: .utf8) {
            delegate?.didReceiveData(SendState(rawValue: message) ?? .unknown, fromPeer: peer)
        }
    }
    
}

extension MPCService: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("MPCService didChange: \(state), from: \(peerID)")
        
        switch state {
        case .notConnected:
            peerDisconnected(peerId: peerID)
        case .connecting:
            break
        case .connected:
            peerConnected(peerId: peerID)
        @unknown default:
            fatalError("Not handled for now")
        }
        
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("MPCService didReceive: \(data), from: \(peerID)")
        
        peerDidShareMessage(data, from: peerID)
//        delegate?.didReceiveData(data, fromPeer: peerID)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        print("MPCService didReceive: \(stream), withName: \(streamName), from: \(peerID)")
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        print("MPCService didStartReceivingResourceWithName: \(resourceName), from: \(peerID), with: \(progress)")
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {
        print("MPCService didFinishReceivingResourceWithName: \(resourceName), from: \(peerID)")
    }
    
}

extension MPCService: MCNearbyServiceBrowserDelegate {
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?) {
        print("Nearby browser foundPeer: \(peerID), withDiscoveryInfo: \(String(describing: info))")

        let isTeamCodeSame = info?["team_code"] == self.advertiserSession.discoveryInfo?["team_code"] && peerSession.connectedPeers.count < maxNumberPeers
            if isTeamCodeSame {
                browser.invitePeer(peerID, to: peerSession, withContext: nil, timeout: 10)
            }
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        print("Nearby browser lostPeer: \(peerID)")
    }
    
}

extension MPCService: MCNearbyServiceAdvertiserDelegate {
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        print("Nearby Advertiser didReceiveInvitationFromPeer: \(peerID), withContext: \(String(describing: context))")
        
        invitationHandler(true, peerSession)
    }
}
