//
//  SVGStyleElement.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/16/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation
import CoreGraphics
import QuartzCore

class SVGStyleElement: StyleElement, Equatable {

    var id: String?
    var classNames: [String]?
    var tagName: String?
    var parentElement: StyleElement?
    var childElements: [StyleElement]?
    var attributes: [String: String]?
    var styles: [String: Any]?
    var properties:[String: StyleDeclaration]?
    
    var isFocused: Bool
    var isEnabled: Bool
    var isSelected: Bool
    var isActive: Bool
    
    init(id: String? = nil, classNames: [String]? = nil, tagName: String? = nil, parent: StyleElement? = nil, children: [StyleElement]? = nil, attributes: [String: String]? = nil) {
      self.id = id
      self.classNames = classNames
      self.tagName = tagName
      self.parentElement = parent
      self.childElements = children
      self.attributes = attributes
      isEnabled = true
      isFocused = false
      isSelected = false
      isActive = false
    }
    
    init(_ tagName:String, _ stylesheet:StyleSheet) {
        self.tagName = tagName
        isEnabled = true
        isFocused = false
        isSelected = false
        isActive = false
        self.properties = stylesheet.stylesForElement(self)
    }
    
    init(_ classNames:[String], _ stylesheet:StyleSheet) {
        self.classNames = classNames
        isEnabled = true
        isFocused = false
        isSelected = false
        isActive = false
        self.properties = stylesheet.stylesForElement(self)
    }
    
    func has(attribute: String, with value: String) -> Bool {
        return attributes?[attribute] == value
    }
    
    func equals(_ other: StyleElement) -> Bool {
        return self == (other as! SVGStyleElement)
    }
    
    func apply(styles: [String : Any]) {
        self.styles = styles
    }
    
    static func == (lhs: SVGStyleElement, rhs: SVGStyleElement) -> Bool {
        return lhs === rhs
    }
    
    func getShapeAttributeModel() -> ShapeAttributeModel {
        var attribute = ShapeAttributeModel()
        
        if let opacity = properties?["opacity"]?.value {
            attribute.opacity = CGFloat(opacity.doubleValue)
        }
        
        if let fill = properties?["fill"]?.value {
            // Check if it is shape
            let shapes = fill.split(separator: "(")
            if shapes.count >= 2 {
                attribute.isFillByShape = true
                attribute.shapeFillId = String(shapes[1]).replacingOccurrences(of: ")", with: "")
            }
            else {
                attribute.fillColor = fill
            }
        }
        
        if let fill_rule = properties?["fill-rule"]?.value  {
            if fill_rule == "nonzero" {
                attribute.fillRule = .nonZero
            }
            else if fill_rule == "evenodd" {
                attribute.fillRule = .evenOdd
            }
        }
        
        if let line_cap = properties?["stroke-linecap"]?.value {
            if line_cap == "round" {
                attribute.lineCap = .round
            }
            else if line_cap == "square" {
                attribute.lineCap = .square
            }
        }
        
        if let line_join = properties?["stroke-linejoin"]?.value {
            if line_join == "bevel" {
                attribute.lineJoin = .bevel
            }
            else if line_join == "round" {
                attribute.lineJoin = .round
            }
        }
        
        if let line_width = properties?["stroke-width"]?.value {
            attribute.lineWidth = CGFloat(line_width.doubleValue)
        }
        
        if let miter_limit = properties?["stroke-miterlimit"]?.value {
            attribute.miterLimit = CGFloat(miter_limit.doubleValue)
        }
        
        if let stroke_color = properties?["stroke"]?.value {
            attribute.strokeColor = stroke_color
        }
        
        return attribute
    }
    
    func getShapeAttributeModel(_ model:SVGDataModel) -> ShapeAttributeModel {
        let attribute = getShapeAttributeModel()
        return ShapeAttributeModel(model, attribute: attribute)
    }
    
    func getPathAttributeModel() -> PathAttributeModel {
        var attribute = PathAttributeModel()
        if let line_cap = properties?["stroke-linecap"]?.value {
            if line_cap == "round" { attribute.lineCapStyle = .round }
            else if line_cap == "square" { attribute.lineCapStyle = .square }
        }
        
        if let line_width = properties?["stroke-width"]?.value {
            attribute.lineWidth = CGFloat(line_width.doubleValue)
        }
        
        if let line_join = properties?["stroke-linejoin"]?.value  {
            if line_join == "bevel" { attribute.lineJoinStyle = .bevel }
            else if line_join == "round" { attribute.lineJoinStyle = .round }
        }
        
        if let miter_limit = properties?["stroke-miterlimit"]?.value {
            attribute.miterLimit = CGFloat(miter_limit.doubleValue)
        }
        
        if let fill_rule = properties?["fill-rule"]?.value , fill_rule == "evenodd" { attribute.usesEvenOddFillRule = true }
        
        if let opacity = properties?["opacity"]?.value {
            attribute.opacity = CGFloat(opacity.doubleValue)
        }
        
        if let stroke = properties?["stroke"]?.value {
            attribute.strokeColor = stroke
        }
        
        if let fill = properties?["fill"]?.value {
            attribute.fillColor = fill
        }
        
        return attribute
    }
    
    func getPathAttributeModel(_ model:SVGDataModel) -> PathAttributeModel {
        let attribute = getPathAttributeModel()
        return PathAttributeModel(model, attribute: attribute)
    }
}

extension Array where Element == SVGStyleElement {
    
}

