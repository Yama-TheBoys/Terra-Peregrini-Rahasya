//
//  SelectRoomHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct SelectRoomHostView: View {
    @EnvironmentObject var router: Router
    @State private var selectedRoom: String? = nil
    @State private var isRGBChecked = false
    @State private var isDoorLockChecked = false
    
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
                
                HStack{
                    Text("RUMAH ")
                        .foregroundStyle(Color.TPRColor.PrimaryBlue)
                    + Text("selected.\n Now, select your room!")
                }
                .font(.customFont(.bold, 18))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .background(
                    Image.Message
                        .resizable()
                        .frame(width: 449, height: 121)
                )
                
                
                
                VStack {
                    RoomButton(title: "BEDROOM", isSelected: selectedRoom == "BEDROOM")
                        .onTapGesture {
                            selectedRoom = "BEDROOM"
                        }
                    
                    if selectedRoom == "BEDROOM"{
                        VStack(alignment: .leading) {
                            Text("Checking...")
                                .customFont(.regular, 16)
                                .padding(.horizontal, 32)
                                .foregroundColor(.white)
                            CustomCheckbox(isChecked: $isRGBChecked, label: "Lamp with RGB")
                                .padding(.top, -20)
                            CustomCheckbox(isChecked: $isDoorLockChecked, label: "Smart Door Lock")
                                .padding(.top, -30)
                        }
                        .padding(.horizontal)
                    }
                    
                    RoomButton(title: "KITCHEN", isSelected: selectedRoom == "KITCHEN")
                        .onTapGesture {
                            selectedRoom = "KITCHEN"
                        }
                    
                    if selectedRoom == "KITCHEN"{
                        VStack(alignment: .leading) {
                            Text("Checking...")
                                .customFont(.regular, 16)
                                .padding(.horizontal, 32)
                                .foregroundColor(.white)
                            CustomCheckbox(isChecked: $isRGBChecked, label: "Lamp with RGB")
                                .padding(.top, -20)
                            CustomCheckbox(isChecked: $isDoorLockChecked, label: "Smart Door Lock")
                                .padding(.top, -30)
                        }
                        .padding(.horizontal)
                    }
                    
                    RoomButton(title: "LIVING ROOM", isSelected: selectedRoom == "LIVING ROOM")
                        .onTapGesture {
                            selectedRoom = "LIVING ROOM"
                        }
                    
                    if selectedRoom == "LIVING ROOM"{
                        VStack(alignment: .leading) {
                            Text("Checking...")
                                .customFont(.regular, 16)
                                .padding(.horizontal, 32)
                                .foregroundColor(.white)
                            CustomCheckbox(isChecked: $isRGBChecked, label: "Lamp with RGB")
                                .padding(.top, -20)
                            CustomCheckbox(isChecked: $isDoorLockChecked, label: "Smart Door Lock")
                                .padding(.top, -30)
                        }
                        .padding(.horizontal)
                    }
                }
                .offset(y: 75)
                    
//                Spacer()
//                Spacer()
//                Spacer()
//                Spacer()
                Spacer()
                
                // if success as host
                Button(action: {
                    router.navigate(to: .roomsuccesshost)
                }, label: {
                    ZStack{
                        Image(selectedRoom == nil ? "DisableButton" : "ProceedButton")
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .foregroundStyle(selectedRoom == nil ? .gray : .white)
                            .fontWeight(.bold)
                            .font(.custom("JetBrainsMono-Regular", size: 18))
                    }
                })
                .disabled(selectedRoom == nil)
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct RoomButton: View {
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

struct CustomCheckbox: View {
    @Binding var isChecked: Bool
    var label: String
    
    @State var isShowCheckMark = false
    
    var body: some View {
        HStack {
            Text(label)
                .customFont(.regular, 16)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
            Spacer()
            
            if isChecked  && isShowCheckMark {
                Image(systemName: "checkmark.square")
                    .foregroundColor(.white)
            } else {
                LoadingProgressView(progress: isChecked ? 1.0 : 0.0)
                    .frame(width: 18, height: 17)
                    .onTapGesture {
                        withAnimation {
                            isChecked.toggle()
                        }
                    }
            }
        }
        .padding()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                isShowCheckMark = true
            }
        }
    }
}

struct LoadingProgressView: View {
    let progress: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(
                    Color.gray.opacity(0.5),
                    lineWidth: 2
                )
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color.white,
                    style: StrokeStyle(
                        lineWidth: 2,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeOut(duration: 4), value: progress)
        }
    }
}

#Preview {
    SelectRoomHostView()
}
