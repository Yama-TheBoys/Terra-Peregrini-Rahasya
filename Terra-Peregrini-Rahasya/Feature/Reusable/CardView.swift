//
//  CardView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 05/07/24.
//

import SwiftUI

struct CardView: View {
    
    let isMission: Bool
    let backgroundColor: EndingStatus
    let title: String
    let description: String
    
    var body: some View {
        ZStack {
            Image.Card
                .resizable()
                .renderingMode(.template)
                .foregroundColor(cardBackgroundColor(endingStatus: backgroundColor))
                .aspectRatio(contentMode: .fit)
                .frame(width: 324, height: 279)
            
            Divider()
                .frame(width: 48, height: 2, alignment: .topLeading)
                .background(.white)
                .padding(.horizontal, 20)
                .offset(x: -103, y: -80)
            
            Text("897123412")
                .foregroundStyle(Color.white)
                .customFont(.bold, 16)
                .padding([.top, .trailing], 48)
                .frame(width: 324, height: 279, alignment: .topTrailing)
            
            if isMission {
                Text(backgroundColor.rawValue)
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 22)
                    .padding(.top, 16)
                    .padding(.leading, 32)
                    .frame(width: 324, height: 279, alignment: .topLeading)
            }
            
            VStack {
                Text(title)
                    .foregroundStyle(Color.white)
                    .customFont(.bold, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 35)
                
                Text(.init(description))
                    .foregroundStyle(Color.white)
                    .customFont(.regular, 14)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.top, 14)
            }
            .padding(.horizontal, 32)
            .frame(width: 324, height: 279)
        }
    }
}

#Preview {
    CardView(isMission: true, backgroundColor: .success, title: "Title", description: "Desc")
}
