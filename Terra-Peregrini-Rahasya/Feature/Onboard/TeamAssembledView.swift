//
//  TeamAssembledView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct TeamAssembledView: View {
    @EnvironmentObject var router: Router
    
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
                    
                    Text("Candidate 1 \nName: Daffa")
                        .font(.custom("JetBrainsMono-Regular", size: 18))
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
                    
                    Text("Candidate 2 \nName: Anjar")
                        .font(.custom("JetBrainsMono-Regular", size: 18))
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
                    
                    Text("Candidate 3 \nName: Yama")
                        .font(.custom("JetBrainsMono-Regular", size: 18))
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
                    
                    Text("Candidate 4 \nName: Jul")
                        .font(.custom("JetBrainsMono-Regular", size: 18))
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
                    
                    Text("Candidate 5 \nName: Nico")
                        .font(.custom("JetBrainsMono-Regular", size: 18))
                        .foregroundStyle(.white)
                        .padding(.top, 20)
                        .padding(.trailing, 225)
                }
                
                Spacer()
                
                Text("The team has been assembeled.")
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
                    playButtonClickSound()
                    router.navigate(to: .roomreqhost)
                }, label: {
                    ZStack{
                        Image.ProceedButton
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .foregroundStyle(Color.white)
                            .fontWeight(.bold)
                            .font(.custom("JetBrainsMono-Regular", size: 18))
                    }
                })
                .padding(.top, 20)
                
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    TeamAssembledView()
}
