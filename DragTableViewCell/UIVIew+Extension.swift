//
//  UIVIew+Extension.swift
//  DragTableViewCell
//
//  Created by xuyazhong on 2020/1/14.
//  Copyright © 2020 xyz. All rights reserved.
//

import UIKit

extension UIView {
 
    public func round (radius: CGFloat, bgColor: UIColor, borderColor: UIColor) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
        layer.borderWidth = 1.0
        layer.borderColor = borderColor.cgColor
        backgroundColor = bgColor
    }
    
}
