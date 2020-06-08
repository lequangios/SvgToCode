//
//  ReviewViewModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 5/1/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import Cocoa
import CoreGraphics

class ReviewViewModel {
    var rootModel:SVGDataModel!
    var rootStyle:StyleSheet!
    var shapes:[CAShapeLayer] = []
    
    init(_ model:SVGDataModel, _ style:StyleSheet) {
        rootModel = model
        rootStyle = style
    }
    
    func makeShapeLayer() -> CAShapeLayer {
        MacosxCode.shared.height = Double(rootModel.frame.size.height)
        MacosxCode.shared.breadthFirstTraverse(model: rootModel, style: rootStyle)
        return MacosxCode.shared.parseModel(rootModel, rootStyle, 0)
    }
}
