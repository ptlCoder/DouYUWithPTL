//
//  UIColor-Extension.swift
//  DYZB
//
//  Created by 1 on 16/9/14.
//  Copyright © 2016年 小码哥. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}

extension UIColor {
    class func kArc4randomColor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
}
