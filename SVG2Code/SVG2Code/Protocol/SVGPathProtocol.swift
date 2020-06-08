//
//  SVGPathProtocol.swift
//  SVG2Code
//
//  Created by Le Quang on 5/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

protocol SVGPathProtocol {
    associatedtype T
    associatedtype V
    func move(command:SVGCommand, obj:V) -> T
    func line(command:SVGCommand, obj:V) -> T
    func quadCurve(command:SVGCommand, obj:V) -> T
    func cubeCurve(command:SVGCommand, obj:V) -> T
    func close(command:SVGCommand, obj:V) -> T
    func applySVGCommand(svgPath: SVGPath, obj:V) -> T
}

