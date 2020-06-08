//
//  CALayer+App.swift
//  SVG2Code
//
//  Created by Le Quang on 6/3/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension CALayer : Comparable {
    public static func < (lhs: CALayer, rhs: CALayer) -> Bool {
        return lhs.zPosition < rhs.zPosition
    }
}
