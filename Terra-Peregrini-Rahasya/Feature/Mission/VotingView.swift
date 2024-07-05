//
//  VotingView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 05/07/24.
//

import SwiftUI

struct VotingView: View {
    @EnvironmentObject var router: Router
    
    @State var playerNames : [String] = ["Jul", "Daffa", "Anjar", "Niko"]
    
    @State var isVotingDone = true
    
    @State var choosenPlayer : String = ""
    
    var body: some View {
        ZStack {
            
            VStack {
                ZStack {
                    Image.Instruction
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .shadow(color: Color.TPRColor.SecondaryPurple ,radius: 10)
                    
                    Text("TIME TO VOTE! PLAYER WITH THE MOST VOTES WILL LOSE POINTS.")
                        .foregroundStyle(Color.white)
                        .customFont(.regular, 18)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 34)
                }
                .padding(.top, 80)
                .padding(.bottom, 40)
                
                ForEach(playerNames, id: \.self) { name in
                    HomeButton(title: name.uppercased(), isSelected: choosenPlayer == name)
                        .onTapGesture {
                            choosenPlayer = name
                        }
                }
                
                Spacer()
                
                Button(action: {
                    isVotingDone = true
                }, label: {
                    ZStack{
                        if choosenPlayer.isEmpty {
                            Image.DisableButton
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } else {
                            Image.ProceedButton
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        Text("Vote")
                            .foregroundStyle(Color.white)
                            .customFont(.bold, 18)
                    }
                })
                .disabled(choosenPlayer.isEmpty)
                .frame(width: 237, height: 81)
                .offset(y: -15)
            }
            
            if isVotingDone {
                
                Color(.black)
                    .opacity(0.7)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    Text(choosenPlayer.uppercased())
                        .foregroundStyle(.white)
                        .customFont(.bold, 64)
                        .shadow(color: .blue, radius: 15)
                    
                    Text("has been voted to lose points.")
                        .foregroundStyle(.white)
                        .customFont(.bold, 20)
                        .frame(width: UIScreen.main.bounds.size.width * 0.5)
                        .multilineTextAlignment(.center)
                        .shadow(color: .blue, radius: 10)
                        
                    
                    Text("-10 pts")
                        .foregroundStyle(.white)
                        .customFont(.bold, 50)
                        .padding(.top, 20)
                        .shadow(color: .red, radius: 15)
                    
                    Spacer()
                    
                    Button(action: {
                        router.navigateBack()
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                            
                            Text("See Clues Now")
                                .foregroundStyle(Color.white)
                                .customFont(.bold, 18)
                        }
                    })
                    .frame(width: 237, height: 81)
                    .offset(y: -15)
                }
            }
//            Text("Hello, World!")
//                .onTapGesture {
//                    router.navigateBack()
//                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.TPRColor.PrimaryPurple)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    VotingView()
}
