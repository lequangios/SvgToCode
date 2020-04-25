//
//  SVGConvertViewModel.swift
//  SVGToSwift
//
//  Created by Le Quang on 4/8/20.
//  Copyright © 2020 Le Viet Quang. All rights reserved.
//

import Foundation

class SVGConvertViewModel {
    var svgType:SVGElementName = SVGElementName.svg
    var langType:LanguageName = LanguageName.Swift
    var svgTxt:String = ""
    var shapeName:String = ""
    var cssTxt:String = ""
    var codeTool = CodeSVG()
    var rootModel:SVGDataModel!
    
    func updateSVGData(_ svgTxt:String, name:String){
        self.svgTxt = svgTxt
        self.shapeName = name
        rootModel = SVGDataModel.init(name)
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
        return code.makePath(element)
    }
    
    private func convertGraph(_ element:SVGDataModel, _ deep:Int)->String{
        let code = CodeSVG.shared
        code.update(self.langType, element)
        return code.makeGrapth(element)
    }
    
    private func convertFileSVG() -> String{
        let manager = SVGXMLManager.shared
        manager.nameLayer = self.shapeName
        manager.xmlString = self.svgTxt
        manager.lang = self.langType
        
        let code = CodeSVG.shared
        code.langName = self.langType
        
        self.rootModel = manager.parseXMLFile(self.shapeName)
        if SVGXMLManager.shared.rootStyle == nil { SVGXMLManager.shared.rootStyle = StyleSheet.init() }
        return CodeSVG.shared.langName.type().getCode(self.rootModel, SVGXMLManager.shared.rootStyle)
    }
    
    private func parseModelTocode(_ model:SVGDataModel)->String {
        return ""
    }
}
