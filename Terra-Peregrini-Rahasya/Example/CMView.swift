//
//  CMView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 06/07/24.
//

import SwiftUI

struct CMView: View {
    var missionManager = MissionManager()
    
    var body: some View {
        Text("CMView")
            .onAppear {
                missionManager.startThirdMission()
            }
            
    }
}

#Preview {
    CMView()
}
