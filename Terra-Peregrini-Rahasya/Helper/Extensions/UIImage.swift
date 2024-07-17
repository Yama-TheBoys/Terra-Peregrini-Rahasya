//
//  UIIMage.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 08/07/24.
//

import Foundation
import UIKit

extension UIImage {
    func overlayWith(image: UIImage, at point: CGPoint, candidateName name: String) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        draw(in: CGRect(origin: point, size: CGSize(width: self.size.width * 0.6, height: self.size.height * 0.6)))
        image.draw(in: CGRect(origin: CGPoint(x: 0, y: 0), size: self.size))
        let combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return combinedImage!.combineImageAndText(text: name, fontName: "Orbitron-Medium").resizeImage()
    }
    
    func combineImageAndText(text: String, fontName: String) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: self.size)
        let img = renderer.image { context in
            // Draw the image
            self.draw(at: CGPoint.zero)

            // Load custom font
            guard let customFont = UIFont(name: fontName, size: 128) else {
                print("Failed to load the custom font.")
                return
            }

            // Define text attributes
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center

            // Set up shadow for the glowing effect
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.white
            shadow.shadowBlurRadius = 10
            shadow.shadowOffset = CGSize.zero

            let attrs: [NSAttributedString.Key: Any] = [
                .font: customFont,
                .paragraphStyle: paragraphStyle,
                .foregroundColor: UIColor.white,
                .shadow: shadow
            ]

            // Determine the position to draw the text
            let textSize = text.size(withAttributes: attrs)
            let textRect = CGRect(x: (self.size.width - textSize.width) / 2,
                                  y: self.size.height - (self.size.height / 3 ) + (2 * (textSize.height / 3)),
                                  width: textSize.width,
                                  height: textSize.height)

            // Draw the text with shadow for glowing effect
            context.cgContext.setShadow(offset: shadow.shadowOffset, blur: shadow.shadowBlurRadius, color: (shadow.shadowColor as? UIColor)?.cgColor)
            text.draw(in: textRect, withAttributes: attrs)

            // Draw the text again to make it sharper
            context.cgContext.setShadow(offset: CGSize.zero, blur: 0, color: nil)
            text.draw(in: textRect, withAttributes: attrs)
        }

        return img
    }
    
    func resizeImage() -> UIImage {
        let size = self.size

        let widthRatio  = 1024  / size.width
        let heightRatio = 1024 / size.height

        // Determine the scale factor that preserves aspect ratio
        let scaleFactor = min(widthRatio, heightRatio)

        // Compute the new image size that preserves aspect ratio
        let scaledImageSize = CGSize(
            width: size.width * scaleFactor,
            height: size.height * scaleFactor
        )

        // Create a graphics context and draw the scaled image
        let renderer = UIGraphicsImageRenderer(size: scaledImageSize)
        let resizedImage = renderer.image { _ in
            self.draw(in: CGRect(origin: .zero, size: scaledImageSize))
        }

        return resizedImage
    }
}
