//
//  SaveImageActivity.swift
//  Terra-Peregrini-Rahasya
//
//  Created by Anjar Harimurti on 08/07/24.
//

import Foundation
import UIKit

class SaveImageActivity: UIActivity {
    var image: UIImage?

    override var activityTitle: String? {
        return "Save Image with Transparency"
    }

    override var activityImage: UIImage? {
        return UIImage(systemName: "square.and.arrow.down")
    }

    override var activityType: UIActivity.ActivityType? {
        return UIActivity.ActivityType("com.yourapp.saveImage")
    }

    override class var activityCategory: UIActivity.Category {
        return .action
    }

    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if item is UIImage {
                return true
            }
        }
        return false
    }

    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if let image = item as? UIImage {
                self.image = image
            }
        }
    }

    override func perform() {
        guard let image = image else { return }

        if let pngData = image.pngData() {
            UIImageWriteToSavedPhotosAlbum(UIImage(data: pngData)!, nil, nil, nil)
        }

        activityDidFinish(true)
    }
}
