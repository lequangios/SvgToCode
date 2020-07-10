//
//  Dictionary+Qy.swift
//  SVGInspector
//
//  Created by Le Quang on 7/8/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

//MARK: - Dictionary with QySVGFomatterStyle + QyAppTemplate
extension Dictionary where Key == String, Value == String {
    func joined() -> String {
        var value = ""
        for data in self.enumerated() {
            value += "\(data.element.key.attribute)\("=".operator)\(data.element.value.quote.attributeValue)"
        }
        return value
    }
}
