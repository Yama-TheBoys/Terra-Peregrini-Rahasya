//
//  MPCService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 27/06/24.
//

import MultipeerConnectivity

final class MPCService: NSObject, ObservableObject {
    
    let serviceType = "tapera-peer"
    let peerSession: MCSession
    let browserSession: MCNearbyServiceBrowser
    let advertiserSession: MCNearbyServiceAdvertiser
    
    @Published var connectedPeers = [MCPeerID]()
    
    init(name: String, teamCode: String) {
        let peerId = MCPeerID(displayName: name)
        
        self.peerSession = MCSession(peer: peerId)
        self.browserSession = MCNearbyServiceBrowser(peer: peerId, serviceType: serviceType)
        self.advertiserSession = MCNearbyServiceAdvertiser(peer: peerId,
                                                           discoveryInfo: ["team_code" : teamCode],
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
    
}

extension MPCService: MCSessionDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("MPCService didChange: \(state), from: \(peerID)")
        DispatchQueue.main.async {
            self.connectedPeers = session.connectedPeers
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        print("MPCService didReceive: \(data), from: \(peerID)")
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
        
        let isTeamCodeSame  = info?["team_code"] == self.advertiserSession.discoveryInfo?["team_code"]
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
