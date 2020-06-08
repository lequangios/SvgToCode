//
//  NSProgressIndicator+App.swift
//  SVG2Code
//
//  Created by Le Quang on 5/22/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Cocoa

extension NSProgressIndicator {
    convenience init(default size:CGSize, color:NSColor) {
        self.init(frame: NSRect(origin: CGPoint.zero, size: size))
        self.style = .spinning
        self.translatesAutoresizingMaskIntoConstraints = false
        set(tintColor: color)
    }
    
    func set(tintColor: NSColor) {
        guard let adjustedTintColor = tintColor.usingColorSpace(.deviceRGB) else {
            contentFilters = []
            return
        }

        let tintColorRedComponent = adjustedTintColor.redComponent
        let tintColorGreenComponent = adjustedTintColor.greenComponent
        let tintColorBlueComponent = adjustedTintColor.blueComponent

        let tintColorMinComponentsVector = CIVector(x: tintColorRedComponent, y: tintColorGreenComponent, z: tintColorBlueComponent, w: 0.0)
        let tintColorMaxComponentsVector = CIVector(x: tintColorRedComponent, y: tintColorGreenComponent, z: tintColorBlueComponent, w: 1.0)

        let colorClampFilter = CIFilter(name: "CIColorClamp")!
        colorClampFilter.setDefaults()
        colorClampFilter.setValue(tintColorMinComponentsVector, forKey: "inputMinComponents")
        colorClampFilter.setValue(tintColorMaxComponentsVector, forKey: "inputMaxComponents")

        contentFilters = [colorClampFilter]
    }
}
