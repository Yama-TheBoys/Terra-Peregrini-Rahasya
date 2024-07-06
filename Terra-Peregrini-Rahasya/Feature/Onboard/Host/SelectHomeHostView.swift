//
//  SelectHomeHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct SelectHomeHostView: View {
    @EnvironmentObject var router: Router
    @State private var selectedRoom: String? = nil
    
    var body: some View {
        ZStack{
            Color.TPRColor.PrimaryPurple
                .ignoresSafeArea()
            
            VStack{
                Button(action: {
                    router.navigateBack()
                }, label: {
                    ZStack{
                        Image.BackButton
                            .resizable()
                            .scaledToFit()
                            .frame(width: 82)
                        Text("BACK")
                            .bold()
                            .font(.custom("JetBrainsMono-Regular", size: 16))
                            .foregroundStyle(.white)
                    }
                })
                .padding(.trailing, 280)
                .padding(.bottom, 60)
                
                Text("Select your home!")
                    .customFont(.bold, 18)
                    .foregroundStyle(.white)
                    .background(
                        Image.Message
                            .resizable()
                            .frame(width: 449, height: 121)
                    )
                Spacer()
                
                HomeButton(title: "RUMAH", isSelected: selectedRoom == "RUMAH")
                    .onTapGesture {
                        selectedRoom = "RUMAH"
                        router.navigate(to: .selectroom)
                    }
                
                HomeButton(title: "KOSAN", isSelected: selectedRoom == "KOSAN")
                    .onTapGesture {
                        selectedRoom = "KOSAN"
                        router.navigate(to: .selectroom)
                    }
                
                HomeButton(title: "RUSUN", isSelected: selectedRoom == "RUSUN")
                    .onTapGesture {
                        selectedRoom = "RUSUN"
                        router.navigate(to: .selectroom)
                    }
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct HomeButton: View {
    var title: String
    var isSelected: Bool
    
    var body: some View {
        ZStack{
            Image(isSelected ? "SelectedHomeButton" : "SelectHomeButton")
                .resizable()
                .frame(width: 319, height: 64)
            Text(title)
                .customFont(.bold, 18)
                .padding()
                .frame(width: 319, height: 64, alignment: .leading)
                .multilineTextAlignment(.leading)
                .foregroundStyle(.white)
        }
        .padding(.bottom, 15)
    }
}

#Preview {
    SelectHomeHostView()
}
