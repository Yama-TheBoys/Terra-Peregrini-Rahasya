//
//  SelectRoomHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct SelectRoomHostView: View {
    @EnvironmentObject var router: Router
    @State private var selectedRoom: String = ""
    
    private var rooms = ["Bedroom", "Kitchen", "Living Room"]
    
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
                    ForEach(rooms, id: \.self) { room in
                        RoomButton(
                            title: room,
                            selectedRoom: selectedRoom,
                            isRGBChecked: $isRGBChecked,
                            isDoorLockChecked: $isDoorLockChecked
                        )
                        .onTapGesture {
                            selectedRoom = room
                            isRGBChecked = false
                            isDoorLockChecked = false
                        }
                    }

                }
                .offset(y: 75)
                    
                Spacer()
                
                // if success as host
                Button(action: {
                    playButtonClickSound()
                    router.navigate(to: .roomsuccesshost)
                }, label: {
                    ZStack{
                        Image(selectedRoom == "" ? "DisableButton" : "ProceedButton")
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .foregroundStyle(selectedRoom == "" ? .gray : .white)
                            .fontWeight(.bold)
                            .font(.custom("JetBrainsMono-Regular", size: 18))
                    }
                })
                .disabled(selectedRoom == "")
            }
            
        }
        .navigationBarBackButtonHidden()
    }
}

struct RoomButton: View {
    let title: String
    let selectedRoom: String
    
    @Binding var isRGBChecked : Bool
    @Binding var isDoorLockChecked : Bool
    
    @State var isClicked: Bool = false
    
    
    var body: some View {
        VStack {
            ZStack{
                Image(title == selectedRoom ? "SelectedHomeButton" : "SelectHomeButton")
                    .resizable()
                    .frame(width: 319, height: 64)
                Text(title.uppercased())
                    .customFont(.bold, 18)
                    .padding()
                    .frame(width: 319, height: 64, alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
            }
            .padding(.bottom, 15)
            
            if title == selectedRoom {
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
                .padding(.horizontal, 24)
            }
        }
    }
}

struct CustomCheckbox: View {
    @Binding var isChecked: Bool
    var label: String
    
    @State var isShowMarkResult = false
    @State var isProgress = false
    
    var body: some View {
        HStack {
            Text(label)
                .customFont(.regular, 16)
                .foregroundColor(.white)
                .padding(.horizontal, 16)
            Spacer()
            
            if isShowMarkResult {
                if isChecked {
                    Image(systemName: "checkmark.square")
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "x.square")
                        .foregroundColor(.red)
                }
                
            } else {
                CircularProgressView(progress: isProgress ? 1.0 : 0.0, isRepeating: false, lineWidth: 4, color: .white)
                    .frame(width: 18, height: 17)
            }
        }
        .padding()
        .onAppear {
            isProgress.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                isShowMarkResult = true
            }
        }
    }
}

#Preview {
    SelectRoomHostView()
}
