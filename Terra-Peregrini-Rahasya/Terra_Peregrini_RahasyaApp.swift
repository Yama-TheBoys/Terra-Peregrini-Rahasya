//
//  Terra_Peregrini_RahasyaApp.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 23/06/24.
//

import SwiftUI

@main
struct Terra_Peregrini_RahasyaApp: App {
    
    @ObservedObject var router = Router()
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $router.navPath) {
                SplashView()
                    .navigationDestination(for: Router.Destination.self) { destination in
                        switch destination {
                        case .onboard:
                            OnboardView()
                        case .setupHome(let apalah):
                            print(apalah)
                        }
                    }
            }
            .environmentObject(router)
        }
    }
}
