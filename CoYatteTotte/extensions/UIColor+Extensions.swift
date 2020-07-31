//
//  UIColor+Extensions.swift
//  CoYatteTotte
//
//  Created by 桜井広大 on 2020/07/21.
//  Copyright © 2020 KotaSakurai. All rights reserved.
//

import UIKit

extension UIColor {
    static let brandColor = UIColor(red: 242/255, green: 171/255, blue: 174/255, alpha: 1.0)
    static let blueColor = UIColor(red: 183/255, green: 207/255, blue: 226/255, alpha: 1.0)
    static let greenColor = UIColor(red: 163/255, green: 198/255, blue: 175/255, alpha: 1.0)
    
    convenience init(hex: String, alpha: CGFloat = 1.0) {
       let v = Int("000000" + hex, radix: 16) ?? 0
       let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
       let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
       let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
       self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
