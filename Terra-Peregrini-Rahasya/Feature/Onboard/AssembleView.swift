//
//  AssembleView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 03/07/24.
//

import SwiftUI

struct AssembleView: View {
    @EnvironmentObject var router: Router
    @State private var showModal = false
    
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
                    
                    Text("Candidate 1 \nName: ") // should be pass the candidate name from NameCodeView
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                .padding(.bottom, -15)
                
                ZStack{
                    Image.Candidate
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.trailing, 100)
                        .opacity(0.4)
                    
                    Text("Candidate 2 \nName: ....")
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                .padding(.bottom, -15)
                
                ZStack{
                    Image.Candidate
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.trailing, 100)
                        .opacity(0.4)
                    
                    Text("Candidate 3 \nName: ....")
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                .padding(.bottom, -15)
                
                ZStack{
                    Image.Candidate
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.trailing, 100)
                        .opacity(0.4)
                    
                    Text("Candidate 4 \nName: ....")
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                .padding(.bottom, -15)
                
                ZStack{
                    Image.Candidate
                        .resizable()
                        .frame(width: 400, height: 100)
                        .padding(.trailing, 100)
                        .opacity(0.4)
                    
                    Text("Candidate 5 \nName: ....")
                        .customFont(.regular, 18)
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                
                Spacer()
                
                Text("Assembling with your team, please wait for other candidates.")
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
                    router.navigate(to: .teamassembled)
                }, label: {
                    ZStack{
                        Image.DisableButton // make if statement
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .customFont(.bold, 18)
                            .foregroundStyle(Color.white)
                    }
                })
                
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
    AssembleView()
}
