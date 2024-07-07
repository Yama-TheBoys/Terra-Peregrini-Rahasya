//
//  NameCodeVIew.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 03/07/24.
//

import SwiftUI

struct NameCodeView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Text("Create a 4-digit team code. All candidates in the room should enter the same code.")
                    .font(.custom("JetBrainsMono-Regular", size: 18))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 16)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 442, height: 121)
                    )
                    .padding()
                
                Spacer()
                
                ZStack{
                    Image.TitleBackground
                        .padding(.trailing, 100)
                    
                    // Text Field belum dicoba
                    Image.InputField
                        .resizable()
                        .frame(width: 240, height: 50)
                        .padding(.leading, 120)
                    
                    Text("Candidate Name")
                        .font(.custom("JetBrainsMono-Regular", size: 16))
                        .foregroundStyle(.white)
                        .padding(.trailing, 200)
                }
                
                ZStack{
                    Image.TitleBackground
                        .padding(.trailing, 100)
                    
                    // Text Field belum dicoba
                    Image.InputField
                        .resizable()
                        .frame(width: 240, height: 50)
                        .padding(.leading, 120)
                    
                    Text("Team Code")
                        .font(.custom("JetBrainsMono-Regular", size: 16))
                        .foregroundStyle(.white)
                        .padding(.trailing, 250)
                    
                }
                
                Spacer()
                Spacer()
                Spacer()
                
                Button(action: {
                    router.navigate(to: .assemble)
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
                .padding()
                    
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    NameCodeView()
}
