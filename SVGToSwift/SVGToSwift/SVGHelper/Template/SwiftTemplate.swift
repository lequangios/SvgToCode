//
//  SwiftTemplate.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/24/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

let swiftExtensionTemplate = """

//
//  SVGExtension.swift
//  SVGToCode
//
//  Created by SVGToCode on 4/21/20.
//  Copyright © 2020 SVGToCode. All rights reserved.
//

import Foundation
import UIKit

public typealias rgba = (r:Int, g:Int, b:Int, a:Double)

extension UIColor{
    convenience init(red: Int, green: Int, blue: Int, alpha:CGFloat) {
        let divisor: CGFloat = 255
        self.init(
            red: CGFloat(red) / divisor,
            green: CGFloat(green) / divisor,
            blue: CGFloat(blue) / divisor,
            alpha: alpha
        )
    }
    
    public convenience init?(hexString: String){
        if hexString.isHexColorString() == true {
            let rgb = hexString.extractRGBA()
            self.init(red: rgb.r, green: rgb.g, blue: rgb.b, alpha: 1)
        }
        else { return nil }
    }
}

extension String {
    public var colorPrefix: String { return "#" }
    
    public var colorValue:UIColor {
        if let color = UIColor.init(hexString: self) {
            return color
        }
        else {
            return UIColor.red
        }
    }
    
    public func isHexColorString()->Bool{
        let check = "#[0-9A-Fa-f]{3}|#[0-9A-Fa-f]{6}"
        let check_value = NSPredicate(format:"SELF MATCHES %@", check)
        return check_value.evaluate(with: self)
    }
    
    public func trim(_ prefix: String) -> String {
        return hasPrefix(prefix) ? String(self.dropFirst(prefix.count)) : self
    }
    
    public func extractRGBA() ->rgba{
        let value = strtoul(trim(colorPrefix), nil, 16)
        let b = value & 0xFF;
        let g = (value >> 8) & 0xFF;
        let r = (value >> 16) & 0xFF;
        
        return (r:Int(r), g:Int(g), b:Int(b), a:1.0)
    }
}

extension CGAffineTransform {
    func makeCATransform3D()->CATransform3D {
        return CATransform3DMakeAffineTransform(self)
    }
    
    static func skew(_ x:CGFloat, _ y:CGFloat)-> CGAffineTransform{
        var matrix = CGAffineTransform.identity
        matrix.a = 1
        matrix.b = tan(x)
        matrix.c = tan(y)
        matrix.d = 1
        matrix.tx = 0
        matrix.ty = 0
        return matrix
    }
    
    static func skewX(_ x:CGFloat)->CGAffineTransform{
        var matrix = CGAffineTransform.identity
        matrix.a = 1
        matrix.b = 0
        matrix.c = tan(x)
        matrix.d = 1
        matrix.tx = 0
        matrix.ty = 0
        return matrix
    }
    
    static func skewY(_ y:CGFloat)->CGAffineTransform{
        var matrix = CGAffineTransform.identity
        matrix.a = 1
        matrix.b = tan(y)
        matrix.c = 0
        matrix.d = 1
        matrix.tx = 0
        matrix.ty = 0
        return matrix
    }
}

extension CAShapeLayer {
    func fill(_ hexColor:String){
        self.fillColor = hexColor.colorValue.cgColor
    }
}

extension UIBezierPath {
    convenience init(ellipse center:CGPoint, rx:CGFloat, ry:CGFloat){
        let rect = CGRect.init(x: center.x - rx, y: center.y - ry, width: rx, height: ry)
        self.init(ovalIn: rect)
    }
    
    convenience init(circle center:CGPoint, radius:CGFloat) {
        self.init(arcCenter: center, radius: radius, startAngle: 0, endAngle: -2*CGFloat.pi, clockwise: true)
    }
    
    convenience init(line point1:CGPoint, point2:CGPoint){
        self.init()
        self.move(to: point1)
        self.addLine(to: point2)
    }
    
    func fillWithHex(_ hexColor:String){
        hexColor.colorValue.setFill()
        self.fill()
    }
    
    func strokeWithHex(_ hexColor:String){
        hexColor.colorValue.setStroke()
        self.stroke()
    }
}


"""

func swiftHeaderTemplate(_ name:String) -> String {
    return """
    func make\(name)Shape()-> CAShapeLayer {
    """
}

func swiftFooterTemplate(_ name:String) -> String {
    return """
        return svg
    }
    """
}
