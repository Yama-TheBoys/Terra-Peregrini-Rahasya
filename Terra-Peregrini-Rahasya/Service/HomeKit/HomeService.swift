//
//  HomeService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import HomeKit

final class HomeService: NSObject {
    
    let homeManager: HMHomeManager
    
    override init() {
        self.homeManager = HMHomeManager()
        super.init()

        self.homeManager.delegate = self
    }
    
    func checkAuthorizationStatus() -> Bool {
        homeManager.authorizationStatus.contains(.authorized)
    }
    
    func addNewAccessory() {
    }
}


