//
//  MPCView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 27/06/24.
//

import SwiftUI

struct MPCView: View {
    
    @ObservedObject var connectivityManager = ConnectivityManager()
    
    @State var name: String = ""
    @State var teamCode: String = ""
    
    var body: some View {
        VStack(spacing: 25) {
            TextField("Name", text: $name)
            TextField("TeamCode", text: $teamCode)
            Button {
                connectivityManager.startConnecting(name: name, teamCode: teamCode)
            } label: {
                Text("Start MPC")
            }
//            if !connectivityManager.players.isEmpty {
//                ForEach(connectivityManager.players.randomElement() ?? ["waitingID" : 9]) { index in
//                    Text("\(connectivityManager.players[index])")
//                }
//            }
        }
    }
}

#Preview {
    MPCView()
}
