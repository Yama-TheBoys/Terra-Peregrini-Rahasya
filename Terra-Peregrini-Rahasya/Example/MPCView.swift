//
//  MPCView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 27/06/24.
//

import SwiftUI

struct MPCView: View {
    
    @ObservedObject var mpcSession = MPCService(name: "Jul", teamCode: "1234")
    
    var body: some View {
        VStack(spacing: 25) {
            Button {
                mpcSession.startBroadcasting()
            } label: {
                Text("Start")
            }
            
//            Button {
//                mpcSession.stop()
//            } label: {
//                Text("Stop")
//            }
        }
    }
}

#Preview {
    MPCView()
}
