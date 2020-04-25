//
//  JSCode.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/9/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

final class JSCode : CodeMaker{    
    static let shared = JSCode()
    
    internal func makeRect(_ rect:CGRect, _ name:String, _ model:SVGDataModel = SVGDataModel())->String{
       return ""
   }
    
    internal func makePath(_ svgPath: SVGPath, _ name:String, _ model:SVGDataModel = SVGDataModel()) -> String {
        return ""
    }
    
    func makeGrapth(_ name: String, _ model: SVGDataModel) -> String {
        return ""
    }
    
    func parseModel(_ model:SVGDataModel, _ style:StyleSheet, _ deep:Int = 0) -> String {
        return ""
    }
    
    func makeSVG(_ model:SVGDataModel)->String {
        return ""
    }
    
    func makeCircle(_ model: SVGDataModel, _ center:CGPoint, _ radius:Double) -> String {
        return ""
    }
    
    func makeClipPath(_ model:SVGDataModel, childs:[CodeGroup]) -> String {
        return ""
    }
    
    func makeDefs(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeEllipse(_ model: SVGDataModel, _ center:CGPoint, _ radius1:Double, _ radius2:Double) -> String {
        return ""
    }
    
    func makeGlyph(_ model: SVGDataModel) -> String {
        return ""
    }
    
    func makeLine(_ model: SVGDataModel, _ point1:CGPoint, _ point2:CGPoint) -> String {
        
        return ""
    }
    
    func makePolyline(_ model:SVGDataModel, _ points:[CGPoint]) -> String {
        return ""
    }
    
    func makeRadialGradient(_ model:SVGDataModel, _ colors:[String], _ locations:[NSNumber], _ point:CGPoint, _ radius:Double) -> String {
        return ""
    }
    
    func makePolygon(_ model:SVGDataModel, _ points:[CGPoint])->String {
        return ""
    }
    
    func getCode(_ model:SVGDataModel, _ style:StyleSheet) -> String {
        return ""
    }
}
