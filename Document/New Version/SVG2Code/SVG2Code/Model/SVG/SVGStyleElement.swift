//
//  SVGStyleElement.swift
//  SVG2Code
//
//  Created by Le Quang on 5/9/20.
//  Copyright © 2020 Le Quang. All rights reserved.
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
}

