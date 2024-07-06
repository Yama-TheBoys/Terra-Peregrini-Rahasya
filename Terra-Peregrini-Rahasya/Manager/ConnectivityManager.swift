//
//  ConnectivityManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 03/07/24.
//

import MultipeerConnectivity

final class ConnectivityManager: ObservableObject {
    
    var mpcService: MPCService?
    var connectedPeers = [MCPeerID]()
        
    init(mpcService: MPCService? = nil) {
        self.mpcService = mpcService
    }
    
    // Call this func first
    func startConnecting(name: String, teamCode: String) {
        self.mpcService = MPCService(name: name, teamCode: teamCode)
        self.mpcService?.delegate = self
                
        self.mpcService?.startBroadcasting()
    }
    
}

extension ConnectivityManager: MPCServiceDelegate {
    func didCompleteConnecting(connectedPeers: [MCPeerID]) {

    }
    
    func didReceiveData(_ data: Data, fromPeer peerId: MCPeerID) {

    }
    
    func didConnectedToPeer(_ peer: MCPeerID) {}
}
