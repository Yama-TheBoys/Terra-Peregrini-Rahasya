//
//  ConnectivityManager.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 03/07/24.
//

import Foundation

final class ConnectivityManager {
    
    let mpcService: MPCService?
    let niService: NIService?
    
    init(mpcService: MPCService?, niService: NIService?) {
        self.mpcService = mpcService
        self.niService = niService
    }
    
    func startConnecting(teamCode: String) {
        
    }
}
