//
//  UIColorExtension.swift
//  ForwardNavigationController_Example
//
//  Created by Mouhammed Ali on 10/31/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

extension UIColor {
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1),
                       green: .random(in: 0...1),
                       blue: .random(in: 0...1),
                       alpha: 1.0)
    }
    var complement: UIColor {
        return self.withHueOffset(offset: 0.5)
    }
    private func withHueOffset(offset: CGFloat) -> UIColor {
        var h: CGFloat = 0
        var s: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getHue(&h, saturation: &s, brightness: &b, alpha: &a)
        return UIColor(hue: fmod(h + offset, 1), saturation: s, brightness: b, alpha: a)
    }
}
