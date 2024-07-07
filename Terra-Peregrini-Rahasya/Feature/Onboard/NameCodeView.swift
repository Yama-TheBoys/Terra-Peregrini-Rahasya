//
//  NameCodeVIew.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 03/07/24.
//

import SwiftUI

struct NameCodeView: View {
    @EnvironmentObject var router: Router
    @State private var candidateName: String = ""
    @State private var teamCode: String = ""
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Text("Create a 4-digit team code. All candidates in the room should enter the same code.")
                    .customFont(.regular, 18)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 442, height: 144)
                    )
                    .padding()
                
//                Spacer()
                
                ScrollView{
                    ZStack{
                        Image.TitleBackground
                            .padding(.trailing, 100)
                        
                        Image.InputField
                            .resizable()
                            .frame(width: 240, height: 50)
                            .padding(.leading, 120)
                        
                        Text("Candidate Name")
                            .customFont(.regular, 16)
                            .foregroundStyle(.white)
                            .padding(.trailing, 200)
                            .overlay(
                                TextField("", text: $candidateName) // belom bisa passing
                                    .font(.customFont(.regular, 16))
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200)
                                    .keyboardType(.namePhonePad)
                                    .padding(.leading, 150)
                            )
                    }
                    
                    ZStack{
                        Image.TitleBackground
                            .padding(.trailing, 100)
                        
                        Image.InputField
                            .resizable()
                            .frame(width: 240, height: 50)
                            .padding(.leading, 120)
                        
                        Text("Team Code")
                            .customFont(.regular, 16)
                            .foregroundStyle(.white)
                            .padding(.trailing, 250)
                            .overlay(
                                TextField("", text: $teamCode)
                                    .font(.customFont(.regular, 16))
                                    .foregroundStyle(.black)
                                    .multilineTextAlignment(.center)
                                    .frame(width: 200)
                                    .keyboardType(.numbersAndPunctuation)
                                    .padding(.leading, 150)
                            )
                    }
                    .padding(.bottom, 300)
                    
                    Button(action: { // button nya belom ke disable klo belom ada input
                        playButtonClickSound()
                        router.navigate(to: .assemble(candidateName: candidateName))
                    }, label: {
                        ZStack{
                            Image.ProceedButton
                                .resizable()
                                .frame(width: 237, height: 81)
                            Text("Proceed")
                                .customFont(.bold, 18)
                                .foregroundStyle(Color.white)
                        }
                    })
                    .padding()
                }
                .padding(.top, 64)
                .scrollIndicators(.hidden)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NameCodeView()
}
