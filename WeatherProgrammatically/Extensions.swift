//
//  Extensions.swift
//  WeatherProgrammatically
//
//  Created by Pavlov Matvey on 09.12.2022.
//

import Foundation
import UIKit

extension Double {
    
    func kelvinToCeliusConverter() -> String {
        let const : Double = 273.15
        let kelValue = self
        let celValue = kelValue - const
        return String(format: "%.0f", celValue)
    }
    
    func cutFractional() -> String {
        let value = self
        return String(format: "%.0f", value)
    }
}

extension Int {
    func incrementWeekDays(by num: Int) -> Int {
        let incrementedVal = self + num
        let mod = incrementedVal % 7
        
        return mod
    }
}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}

extension String {
    func correctTime() -> String {
        let firstIndex = self.index(self.endIndex, offsetBy: -8)
        let lastIndex = self.index(self.endIndex, offsetBy: -3)
        return String(self[firstIndex..<lastIndex])
    }
}

let imageCache = NSCache<AnyObject, AnyObject>()
let cachedImages = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImageFromURL(url: String) {
        self.image = nil
        guard let URL = URL(string: url) else {
            print("No Image For this url", url)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: URL) {
                if let image = UIImage(data: data) {
                    let imageTocache = image
                    imageCache.setObject(imageTocache, forKey: url as AnyObject)
                    
                    DispatchQueue.main.async {
                        self?.image = imageTocache
                    }
                }
            }
        }
    }
}


