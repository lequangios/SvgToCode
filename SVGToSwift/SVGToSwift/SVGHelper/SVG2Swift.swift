//
//  SVG2Swift.swift
//  SVGToSwift
//
//  Created by Le Viet Quang on 9/16/18.
//  Copyright © 2018 Le Viet Quang. All rights reserved.
//

import Foundation
import AppKit
import CoreGraphics

// MARK: String
public extension String {
    var floatValue: Float { return strtof(self, nil)}
    var doubleValue: Double { return strtod(self, nil)}
}

public extension CGFloat{
    var str:String{return String(format: "%.1f", self)}
}

// MARK: UIBezierPath

public extension String {
    func addNewlineCode(_ code:String)->String{
        let current = self
        return "\(current)\n\(code)"
    }
    
    static func getCode(svgPath: String, name:String)->String{
        let str = ""
        return str.applyCommandsCode(from: SVGPath(svgPath), name:name)
    }
}


public extension String {
    func applyCommandsCode(from svgPath: SVGPath, name:String) -> String{
        var code:String = "let \(name) = UIBezierPath()\n"
        for command in svgPath.commands {
            switch command.type {
            case .move:
                //move(to: command.point)
                code += "\(name).move(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                break
            case .line:
                //addLine(to: command.point)
                code += "\(name).addLine(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)))\n"
                break
            case .quadCurve:
                //addQuadCurve(to: command.point, controlPoint: command.control1)
                code += "\(name).addQuadCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)))\n"
                break
            case .cubeCurve:
                //addCurve(to: command.point, controlPoint1: command.control1, controlPoint2: command.control2)
                code += "\(name).addCurve(to: CGPoint(x: \(command.point.x.str), y: \(command.point.y.str)), controlPoint1: CGPoint(x: \(command.control1.x.str), y: \(command.control1.y.str)), controlPoint2: CGPoint(x: \(command.control2.x.str), y: \(command.control2.y.str)))\n"
                break
            case .close:
                //close()
                code += "\(name).close()\n"
                break
            case .style:
                code += "\(name).fill(\"\(command.nameStyle)\")\n"
            }
        }
        return code
    }
}

// MARK: Enums
fileprivate enum Coordinates {
    case absolute
    case relative
}

// MARK: Class
public class SVGPath {
    public var commands: [SVGCommand] = []
    private var builder: SVGCommandBuilder = move
    private var coords: Coordinates = .absolute
    private var increment: Int = 2
    private var numbers = ""
    
    public init (_ string: String) {
        for char in string {
            switch char {
            case "M": use(.absolute, 2, move)
            case "m": use(.relative, 2, move)
            case "L": use(.absolute, 2, line)
            case "l": use(.relative, 2, line)
            case "V": use(.absolute, 1, lineVertical)
            case "v": use(.relative, 1, lineVertical)
            case "H": use(.absolute, 1, lineHorizontal)
            case "h": use(.relative, 1, lineHorizontal)
            case "Q": use(.absolute, 4, quadBroken)
            case "q": use(.relative, 4, quadBroken)
            case "T": use(.absolute, 2, quadSmooth)
            case "t": use(.relative, 2, quadSmooth)
            case "C": use(.absolute, 6, cubeBroken)
            case "c": use(.relative, 6, cubeBroken)
            case "S": use(.absolute, 4, cubeSmooth)
            case "s": use(.relative, 4, cubeSmooth)
            case "Z": use(.absolute, 1, close)
            case "z": use(.absolute, 1, close)
            default: numbers.append(char)
            }
        }
        finishLastCommand()
    }
    
    private func use (_ coords: Coordinates, _ increment: Int, _ builder: @escaping SVGCommandBuilder) {
        finishLastCommand()
        self.builder = builder
        self.coords = coords
        self.increment = increment
    }
    
    private func finishLastCommand () {
        for command in take(SVGPath.parseNumbers(numbers), increment: increment, coords: coords, last: commands.last, callback: builder) {
            commands.append(coords == .relative ? command.relative(to: commands.last) : command)
        }
        numbers = ""
    }
}


// MARK: Numbers

private let numberSet = CharacterSet(charactersIn: "-.0123456789eE")
private let locale = Locale(identifier: "en_US")


public extension SVGPath {
    class func parseNumbers (_ numbers: String) -> [CGFloat] {
        var all:[String] = []
        var curr = ""
        var last = ""
        
        for char in numbers.unicodeScalars {
            let next = String(char)
            if next == "-" && last != "" && last != "E" && last != "e" {
                if curr.utf16.count > 0 {
                    all.append(curr)
                }
                curr = next
            } else if numberSet.contains(UnicodeScalar(char.value)!) {
                curr += next
            } else if curr.utf16.count > 0 {
                all.append(curr)
                curr = ""
            }
            last = next
        }
        
        all.append(curr)
        
        //return all.map { CGFloat(NSDecimalNumber(string: $0, locale: locale)) }
        return all.map{CGFloat($0.floatValue)}
    }
}

// MARK: Commands

public struct SVGCommand {
    public var point:CGPoint
    public var control1:CGPoint
    public var control2:CGPoint
    public var nameStyle:String
    public var type:Kind
    
    public enum Kind {
        case move
        case line
        case cubeCurve
        case quadCurve
        case close
        case style
    }
    
    public init () {
        let point = CGPoint()
        self.init(point, point, point, type: .close)
    }
    
    public init (_ x: CGFloat, _ y: CGFloat, type: Kind) {
        let point = CGPoint(x: x, y: y)
        self.init(point, point, point, type: type)
    }
    
    public init (_ cx: CGFloat, _ cy: CGFloat, _ x: CGFloat, _ y: CGFloat) {
        let control = CGPoint(x: cx, y: cy)
        self.init(control, control, CGPoint(x: x, y: y), type: .quadCurve)
    }
    
    public init (_ cx1: CGFloat, _ cy1: CGFloat, _ cx2: CGFloat, _ cy2: CGFloat, _ x: CGFloat, _ y: CGFloat) {
        self.init(CGPoint(x: cx1, y: cy1), CGPoint(x: cx2, y: cy2), CGPoint(x: x, y: y), type: .cubeCurve)
    }
    
    public init (_ control1: CGPoint, _ control2: CGPoint, _ point: CGPoint, type: Kind, nameStyle:String = "") {
        self.point = point
        self.control1 = control1
        self.control2 = control2
        self.type = type
        self.nameStyle = ""
    }
    
    fileprivate func relative (to other:SVGCommand?) -> SVGCommand {
        if let otherPoint = other?.point {
            return SVGCommand(control1 + otherPoint, control2 + otherPoint, point + otherPoint, type: type)
        }
        return self
    }
}

// MARK: CGPoint helpers

private func +(a:CGPoint, b:CGPoint) -> CGPoint {
    return CGPoint(x: a.x + b.x, y: a.y + b.y)
}

private func -(a:CGPoint, b:CGPoint) -> CGPoint {
    return CGPoint(x: a.x - b.x, y: a.y - b.y)
}

// MARK: Command Builders

private typealias SVGCommandBuilder = ([CGFloat], SVGCommand?, Coordinates) -> SVGCommand

private func take (_ numbers: [CGFloat], increment: Int, coords: Coordinates, last: SVGCommand?, callback: SVGCommandBuilder) -> [SVGCommand] {
    var out: [SVGCommand] = []
    var lastCommand:SVGCommand? = last
    
    let count = (numbers.count / increment) * increment
    var nums:[CGFloat] = [0, 0, 0, 0, 0, 0];
    
    for i in stride(from: 0, to: count, by: increment) {
        for j in 0 ..< increment {
            nums[j] = numbers[i + j]
        }
        lastCommand = callback(nums, lastCommand, coords)
        out.append(lastCommand!)
    }
    
    return out
}

// MARK: Mm - Move

private func move (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand(numbers[0], numbers[1], type: .move)
}

// MARK: Ll - Line

private func line (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand(numbers[0], numbers[1], type: .line)
}

// MARK: Vv - Vertical Line

private func lineVertical (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand(coords == .absolute ? last?.point.x ?? 0 : 0, numbers[0], type: .line)
}

// MARK: Hh - Horizontal Line

private func lineHorizontal (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand(numbers[0], coords == .absolute ? last?.point.y ?? 0 : 0, type: .line)
}

// MARK: Qq - Quadratic Curve To

private func quadBroken (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand(numbers[0], numbers[1], numbers[2], numbers[3])
}

// MARK: Tt - Smooth Quadratic Curve To

private func quadSmooth (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    var lastControl = last?.control1 ?? CGPoint()
    let lastPoint = last?.point ?? CGPoint()
    if (last?.type ?? .line) != .quadCurve {
        lastControl = lastPoint
    }
    var control = lastPoint - lastControl
    if coords == .absolute {
        control = control + lastPoint
    }
    return SVGCommand(control.x, control.y, numbers[0], numbers[1])
}

// MARK: Cc - Cubic Curve To

private func cubeBroken (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand(numbers[0], numbers[1], numbers[2], numbers[3], numbers[4], numbers[5])
}

// MARK: Ss - Smooth Cubic Curve To

private func cubeSmooth (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    var lastControl = last?.control2 ?? CGPoint()
    let lastPoint = last?.point ?? CGPoint()
    if (last?.type ?? .line) != .cubeCurve {
        lastControl = lastPoint
    }
    var control = lastPoint - lastControl
    if coords == .absolute {
        control = control + lastPoint
    }
    return SVGCommand(control.x, control.y, numbers[0], numbers[1], numbers[2], numbers[3])
}

// MARK: Zz - Close Path

private func close (_ numbers: [CGFloat], last: SVGCommand?, coords: Coordinates) -> SVGCommand {
    return SVGCommand()
}
 
