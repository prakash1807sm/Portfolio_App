//
//  Extensions.swift
//  Prakash_Rajak_HoldingDetails
//
//  Created by Prakash Rajak on 25/12/25.
//

import UIKit

extension UIColor {
    static func colorWithHexString(hex: String) -> UIColor {
        var colorString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if colorString.hasPrefix("#") {
            colorString.remove(at: colorString.startIndex)
        }
        
        if colorString.count != 6 {
            return UIColor.brown
        }
        var rgbValue: UInt64 = 0
        Scanner(string: colorString).scanHexInt64(&rgbValue)
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
            
        )
    }
}

extension Double {
    func truncatedTwoDecimals() -> Double {
        let t = floor(self * 100) / 100
        return t * 10 == floor(t * 10) ? floor(t * 10) / 10 : t
    }
}
