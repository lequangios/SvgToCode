//
//  CATransition+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/9/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension CATransition {
    static var push:CATransition {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        return transition
    }
}
