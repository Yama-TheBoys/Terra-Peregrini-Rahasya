//
//  Unit.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 04/07/24.
//

import Foundation
import SwiftUI

func cardBackgroundColor(endingStatus: EndingStatus?) -> Color {
    return switch endingStatus {
    case .success:
        Color.TPRColor.SuccessGreen
        
    case .failed:
        Color.TPRColor.FailedRed
        
    case .ingame:
        Color.TPRColor.SecondaryPurple
        
    case .none:
        Color.TPRColor.SecondaryPurple
        
    case .defaults:
        Color.TPRColor.PrimaryBlue
    }
}
