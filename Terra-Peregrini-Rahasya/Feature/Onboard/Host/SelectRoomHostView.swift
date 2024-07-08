//
//  SelectRoomHostView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 04/07/24.
//

import SwiftUI

struct SelectRoomHostView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var connectivityManager: ConnectivityManager
    
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
                    Text("\(connectivityManager.selectedHome?.name ?? "RUMAH") ")
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
//<<<<<<< HEAD
//                    ForEach(0..<connectivityManager.rooms.count) { index in
//                        RoomButton(title: connectivityManager.rooms[index].name, isSelected: selectedRoom == connectivityManager.rooms[index].name)
//                            .onTapGesture {
//                                selectedRoom = connectivityManager.rooms[index].name
//                                connectivityManager.checkRoomAvailabilityFromIndex(index) { isRGBAvailable, isDoorLockAvailable in
//                                    self.isRGBChecked = isRGBAvailable
//                                    self.isDoorLockChecked = isDoorLockAvailable
//                                }
//                            }
//                        
//                        if selectedRoom == connectivityManager.rooms[index].name {
//                            VStack(alignment: .leading) {
//                                Text("Checking...")
//                                    .customFont(.regular, 16)
//                                    .padding(.horizontal, 32)
//                                    .foregroundColor(.white)
//                                CustomCheckbox(isChecked: $isRGBChecked, label: "Lamp with RGB")
//                                    .padding(.top, -20)
//                                CustomCheckbox(isChecked: $isDoorLockChecked, label: "Smart Door Lock")
//                                    .padding(.top, -30)
//                            }
//                            .padding(.horizontal)
//=======
                    ForEach(0..<connectivityManager.rooms.count, id: \.self) { index in
                        RoomButton(
                            title: connectivityManager.rooms[index].name,
                            selectedRoom: connectivityManager.rooms[index].name,
                            isRGBChecked: $isRGBChecked,
                            isDoorLockChecked: $isDoorLockChecked
                        )
                        .onTapGesture {
//                            selectedRoom = room
//                            isRGBChecked = false
//                            isDoorLockChecked = false
                            selectedRoom = connectivityManager.rooms[index].name
                            connectivityManager.checkRoomAvailabilityFromIndex(index) { isRGBAvailable, isDoorLockAvailable in
                                self.isRGBChecked = isRGBAvailable
                                self.isDoorLockChecked = isDoorLockAvailable
                            }
//>>>>>>> development
                        }
                    }

                }
                .offset(y: 75)
                    
                Spacer()
                
                Button(action: {
                    connectivityManager.sendMessageSuccessHomeSetup()
                    playButtonClickSound()
                    router.navigate(to: .roomsuccesshost)
                }, label: {
                    ZStack{
                        Image(isRGBChecked && isDoorLockChecked ? "ProceedButton" : "DisableButton")
                            .resizable()
                            .frame(width: 237, height: 81)
                        Text("Proceed")
                            .foregroundStyle(isRGBChecked && isDoorLockChecked ? .white : .gray)
                            .fontWeight(.bold)
                            .font(.custom("JetBrainsMono-Regular", size: 18))
                    }
                })
                .disabled(!isRGBChecked || !isDoorLockChecked)
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
