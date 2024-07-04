//
//  FinalCodeView.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import SwiftUI

struct CodeView: View {
    @Binding var code: String
    var endingStatus: EndingStatus?
    
    var body: some View {
        Image.FinalCode
            .resizable()
            .renderingMode(.template)
            .foregroundColor(cardBackgroundColor(endingStatus: endingStatus))
            .scaledToFit()
            .frame(width: 72)
            .shadow(color: Color.TPRColor.LightPurple ,radius: 1.5)
            .overlay(alignment: .center) {
                TextField("", text: $code)
                    .foregroundStyle(Color.white)
                    .font(.customFont(.regular, 28))
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
            }
    }
}

struct FinalCodeView: View {
    @Binding var code: [String]
    @Binding var isComplete: Bool
    var endingStatus: EndingStatus?
    
    @FocusState private var focusedField: CodeField?
    
    var body: some View {
        HStack(spacing: 0) {
            
            CodeView(code: $code[0], endingStatus: endingStatus)
                .focused($focusedField, equals: .code1)
                .onChange(of: code[0]) {
                    if code[0].count == 1 {
                        focusedField = .code2
                        isComplete = false
                    }
                }
            
            CodeView(code: $code[1], endingStatus: endingStatus)
                .focused($focusedField, equals: .code2)
                .onChange(of: code[1]) {
                    if code[1].count == 1 {
                        focusedField = .code3
                        isComplete = false
                    }
                }
            
            CodeView(code: $code[2], endingStatus: endingStatus)
                .focused($focusedField, equals: .code3)
                .onChange(of: code[2]) {
                    if code[2].count == 1 {
                        focusedField = .code4
                        isComplete = false
                    }
                }
            
            CodeView(code: $code[3], endingStatus: endingStatus)
                .focused($focusedField, equals: .code4)
                .onChange(of: code[3]) {
                    if code[3].count == 1 {
                        focusedField = nil
                        isComplete = true
                    }
                }
        }
    }
}

enum CodeField {
        case code1, code2, code3, code4
    }

#Preview {
    FinalCodeView(code: .constant(["0","0","0","0"]), isComplete: .constant(false))
}

#Preview {
    CodeView(code: .constant("0"))
}
