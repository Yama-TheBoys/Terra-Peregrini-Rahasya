//
//  NIService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 02/07/24.
//

import NearbyInteraction

protocol NIServiceDelegate: AnyObject {
    func didUpdate(nearbyObjects: [NINearbyObject])
}

final class NIService: NSObject {
    
    static func createNewNISession() -> NISession {
        NISession()
    }
    
    weak var delegate: NIServiceDelegate?
    
    func checkAvailibility() -> Bool {
        NISession.deviceCapabilities.supportsCameraAssistance &&
        NISession.deviceCapabilities.supportsDirectionMeasurement &&
        NISession.deviceCapabilities.supportsExtendedDistanceMeasurement &&
        NISession.deviceCapabilities.supportsPreciseDistanceMeasurement
    }
    
    func run(session: NISession, discoveryToken: NIDiscoveryToken) {
        let configuration = NINearbyPeerConfiguration(peerToken: discoveryToken)
        session.run(configuration)
    }
    
    func pause(session: NISession) {
        session.pause()
    }
    
    func runAgain(session: NISession) {
        guard let configuration = session.configuration else { return }
        session.run(configuration)
    }
    
}

extension NIService: NISessionDelegate {
    func session(_ session: NISession, didUpdate nearbyObjects: [NINearbyObject]) {
        delegate?.didUpdate(nearbyObjects: nearbyObjects)
    }
    
    func session(_ session: NISession, didRemove nearbyObjects: [NINearbyObject], reason: NINearbyObject.RemovalReason) {
        print("didRemove: \(nearbyObjects), reason: \(reason)")
    }
    
    func sessionWasSuspended(_ session: NISession) {
        pause(session: session)
    }
    
    func sessionSuspensionEnded(_ session: NISession) {
        runAgain(session: session)
    }
}
