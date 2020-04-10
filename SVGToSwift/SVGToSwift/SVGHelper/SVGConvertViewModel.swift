//
//  SVGConvertViewModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/8/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

class SVGConvertViewModel {
    var svgType:SVGElementName = SVGElementName.path
    var langType:LanguageName = LanguageName.Swift
    var svgTxt:String = ""
    var shapeName:String = ""
    var cssTxt:String = ""
    var codeTool = CodeSVG()
    var rootModel = SVGDataModel()
    
    func updateSVGData(_ svgTxt:String, name:String){
        self.svgTxt = svgTxt
        self.shapeName = name
    }
    
    func convertSVG(_ model:SVGDataModel, _ deep:Int, _ complete:@escaping(Result<String,NSError>)->Void){
        DispatchQueue.global(qos: .utility).sync { [weak self] in
            if let strongSelf = self {
                var text = ""
                if strongSelf.svgType == .path {
                    text = strongSelf.convertPath(model, deep)
                    complete(.success(text))
                }
                else if strongSelf.svgType == .g {
                    text = strongSelf.convertGraph(model, deep)
                    complete(.success(text))
                }
                else if strongSelf.svgType == .svg {
                    text = strongSelf.convertFileSVG()
                    complete(.success(text))
                }
                else{
                    let e = NSError.init(msg: "\(strongSelf.svgType.rawValue) is not supported")
                    complete(.failure(e))
                }
            }
        }
    }
    
    private func convertPath(_ element:SVGDataModel, _ deep:Int)->String{
        let code = CodeSVG.shared
        code.update(self.langType, element)
        return code.makePath(element, deep)
    }
    
    private func convertGraph(_ element:SVGDataModel, _ deep:Int)->String{
        let code = CodeSVG.shared
        code.update(self.langType, element)
        return code.makeGrapth(element, deep)
    }
    
    private func convertFileSVG() -> String{
        let manager = SVGXMLManager.init(self.svgTxt, name: self.shapeName, rootModel: self.rootModel, lang: self.langType)
        self.rootModel = manager.parseXMLFile()
        return ""
    }
    
    private func parseModelTocode(_ model:SVGDataModel)->String {
        return ""
    }
}
