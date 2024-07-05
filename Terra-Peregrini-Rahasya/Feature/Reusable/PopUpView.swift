//
//  PopUpView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 06/07/24.
//

import SwiftUI

struct PopUpView: View {
    
    @Binding var isActive: Bool
    
    @State private var offset: CGFloat = 1000
    
    var message: String
    var onYes: () -> Void
    var onNo: () -> Void
    
    var body: some View {
        ZStack {
            Color(.black)
                .opacity(0.7)
                .onTapGesture {
                    closeDialog()
                }
            
            Image.Alert
                .resizable()
                .frame(maxWidth: UIScreen.main.bounds.size.width * 0.85, maxHeight: UIScreen.main.bounds.size.height * 0.25)
                .cornerRadius(12)
                .overlay {
                    VStack {
                        Spacer()
                        
                        Text(message)
                            .foregroundStyle(.white)
                            .customFont(.bold, 18)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                        
                        Spacer()
                        
                        Divider()
                            .frame(height: 1)
                            .background(.white)
                        
                        HStack(spacing: 0) {
                            Button(action: {
                                closeDialog()
                                onNo()
                            }) {
                                Text("No")
                                    .foregroundStyle(.white)
                                    .customFont(.bold, 18)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                            
                            Divider()
                                .frame(width: 1, height: 44)
                                .background(.white)
                            
                            Button(action: {
                                closeDialog()
                                onYes()
                            }) {
                                Text("Yes")
                                    .foregroundStyle(.white)
                                    .customFont(.bold, 18)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .onTapGesture {
                        closeDialog()
                    }
                }

            .frame(maxWidth: UIScreen.main.bounds.size.width - 100)
            .clipped()
            .cornerRadius(12)
            .shadow(radius: 20)
            .offset(x: 0, y: offset)
        }
        .onAppear {
            withAnimation(.spring()) {
                offset = 0
            }
        }
        .ignoresSafeArea()
    }
    
    
    func closeDialog() {
        withAnimation(.spring()) {
            offset = 1000
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                isActive = false
            }
        }
    }
}

#Preview {
    PopUpView(
        isActive: .constant(true),
        message: "Camera access was previously denied. Do you want to allow it in Settings?",
        onYes: {
            print("User selected Yes")
        },
        onNo: {
            print("User selected No")
        })
}
