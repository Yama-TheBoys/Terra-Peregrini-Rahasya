//
//  OnboardView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Daffashiddiq on 26/06/24.
//

import SwiftUI

struct OnboardView: View {
    @EnvironmentObject var router: Router
    
    var body: some View {
        VStack {
            Button(action: {
                router.navigateBack()
            }, label: {
                Text("Back")
            })
        }
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    OnboardView()
}
