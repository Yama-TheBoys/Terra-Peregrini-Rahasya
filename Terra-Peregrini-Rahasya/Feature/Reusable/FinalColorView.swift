//
//  FinalColorView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import SwiftUI

struct FinalColorView: View {
    
    @Binding var colorCode: [Color]
    
    var body: some View {
        HStack(spacing: 17) {
            Image.Phone
                .resizable()
                .scaledToFit()
                .frame(width: 68)
                .overlay(alignment: .center) {
                    Image(systemName: "bolt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .foregroundStyle(colorCode[0])
                }
            
            Image.Phone
                .resizable()
                .scaledToFit()
                .frame(width: 68)
                .overlay(alignment: .center) {
                    Image(systemName: "bolt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .foregroundStyle(colorCode[1])
                }
            
            Image.Phone
                .resizable()
                .scaledToFit()
                .frame(width: 68)
                .overlay(alignment: .center) {
                    Image(systemName: "bolt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .foregroundStyle(colorCode[2])
                }
            
            Image.Phone
                .resizable()
                .scaledToFit()
                .frame(width: 68)
                .overlay(alignment: .center) {
                    Image(systemName: "bolt")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15)
                        .foregroundStyle(colorCode[3])
                }
        }
    }
}

#Preview {
    FinalColorView(colorCode: .constant([.white, .white, .blue, .white]))
}
