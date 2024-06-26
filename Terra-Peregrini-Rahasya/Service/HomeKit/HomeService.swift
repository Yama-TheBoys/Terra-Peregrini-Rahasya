//
//  HomeService.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import HomeKit

final class HomeService: NSObject {
    
    let homeManager: HMHomeManager
    let accessoriesSetupManager: HMAccessorySetupManager
    
    override init() {
        self.homeManager = HMHomeManager()
        self.accessoriesSetupManager = HMAccessorySetupManager()
        super.init()

        self.homeManager.delegate = self
    }
    
    func checkAuthorizationStatus() -> Bool {
        homeManager.authorizationStatus.contains(.authorized)
    }
    
    func addNewAccessory() {
    }
}


