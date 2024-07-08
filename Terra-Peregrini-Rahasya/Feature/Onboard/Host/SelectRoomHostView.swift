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
                    ForEach(0..<connectivityManager.rooms.count) { index in
                        RoomButton(title: connectivityManager.rooms[index].name, isSelected: selectedRoom == connectivityManager.rooms[index].name)
                            .onTapGesture {
                                selectedRoom = connectivityManager.rooms[index].name
                                connectivityManager.checkRoomAvailabilityFromIndex(index) { isRGBAvailable, isDoorLockAvailable in
                                    self.isRGBChecked = isRGBAvailable
                                    self.isDoorLockChecked = isDoorLockAvailable
                                }
                            }
                        
                        if selectedRoom == connectivityManager.rooms[index].name {
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
                }
                .offset(y: 75)
                    
                Spacer()
                
                Button(action: {
                    connectivityManager.sendMessageSuccessHomeSetup()
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
                .animation(.easeOut(duration: 2), value: progress)
        }
    }
}

#Preview {
    SelectRoomHostView()
}
