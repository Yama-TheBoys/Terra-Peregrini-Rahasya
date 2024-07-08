//
//  AssembleView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 03/07/24.
//

import SwiftUI

struct AssembleView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    @State private var showModal = false

    var candidateName: String
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                ZStack{
                    Image.Candidate
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.trailing, 100)
                    
                    Text("Candidate 1 \nName: \(candidateName)")
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                .padding(.bottom, -15)
                
                ForEach(0 ..< 4, id: \.self) { index in
                    ZStack{
                        Image.Candidate
                            .resizable()
                            .frame(width: 400, height: 100)
                            .padding(.trailing, 100)
                            .opacity(isCandidateExist(index) ? 1 : 0.4)
                        
                        Text("Candidate \(index+2) \nName: \(isCandidateExist(index))")
                            .customFont(.regular, 18)
                            .foregroundStyle(.white)
                            .padding(.top, 20)
                            .padding(.trailing, 225)
                    }
                    .padding(.bottom, -15)
                }
                
                Spacer()
                
                Text(isAssembled() ? "The team has been assembeled." : "Assembling with your team, please wait for other candidates.")
                    .padding(.horizontal, 72)
                    .multilineTextAlignment(.center)
                    .font(.custom("JetBrainsMono-Regular", size: 18))
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                
                Button(action: {
                    connectivityManager.proceedToHomeOnboard()
                    router.navigate(to: .roomreqhost)
                }, label: {
                    ZStack{
                        
                        isAssembled() ?
                        Image.ProceedButton // make if statement
                            .resizable()
                            .frame(width: 237, height: 81)
                        :
                        Image.DisableButton // make if statement
                            .resizable()
                            .frame(width: 237, height: 81)
                        
                        Text("Proceed")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .disabled(!isAssembled())
                
                Button(action: {
                    showModal = true
                }, label: {
                    ZStack{
                        Image.HelpButton
                            .resizable()
                            .frame(width: 103, height: 37)
                        Text("Help")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                .offset(y: -10)
                .sheet(isPresented: $showModal) {
                    HelpModalView()
                        .presentationDetents([.fraction(0.25), .fraction(0.5)])
                        .presentationDragIndicator(.visible)
                }
            }
        }
        .navigationBarBackButtonHidden()
        .onChange(of: connectivityManager.isAssembledDone) {
            isEveryoneReady()
        }
    }
    
    func isAssembled() -> Bool {
        connectivityManager.connectedPeers.count == 4
    }
    
    func isCandidateExist(_ index: Int) -> String {
        connectivityManager.connectedPeers.count > index ? connectivityManager.connectedPeers[index].displayName : "..."
    }
    
    func isCandidateExist(_ index: Int) -> Bool {
        connectivityManager.connectedPeers.count > index
    }
    
    func isEveryoneReady() {
        if connectivityManager.isAssembledDone {
            router.navigate(to: .roomreqhost)
        }
    }
}

struct HelpModalView: View {
    var body: some View{
        ZStack {
            Color.TPRColor.LightBlue
                .ignoresSafeArea()
            
            Text("To start the game, ensure there are exactly five players. This number is crucial for the game mechanics and optimal experience. Without five players, the game cannot begin.")
                .customFont(.bold, 18)
                .padding(.top, 24)
                .padding(.horizontal, 24)
                .foregroundColor(.white)
                .cornerRadius(16)
        }
    }
}

#Preview {
    AssembleView(candidateName: "Daf")
}
