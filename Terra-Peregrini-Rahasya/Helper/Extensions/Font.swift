//
//  Font.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Julius Adetya on 02/07/24.
//

import SwiftUI

enum FontWeight {
    case regular
    case bold
    case italic
}

extension Font {
    static let customFont: (FontWeight, CGFloat) -> Font = { fontType, size in
        switch fontType {
        case .regular:
            Font.custom("JetBrainsMono-Regular", size: size)
        case .bold:
            Font.custom("JetBrainsMono-Bold", size: size)
        case .italic:
            Font.custom("JetBrainsMono-Italic", size: size)
        }
    }
}

extension Text {
    func customFont(_ fontWeight: FontWeight? = .regular, _ size: CGFloat? = nil) -> Text {
        return self.font(.customFont(fontWeight ?? .regular, size ?? 16))
    }
}
