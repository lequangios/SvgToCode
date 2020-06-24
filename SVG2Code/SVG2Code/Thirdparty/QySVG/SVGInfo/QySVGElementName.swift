//
//  QySVGElementName.swift
//  SVG2Code
//
//  Created by Le Quang on 6/18/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

enum QySVGTagCategory {
    case kAnimationElements
    case kBasicShapes
    case kContainerElements
    case kDescriptiveElements
    case kFilterPrimitiveElements
    case kFontElements
    case kGradientElements
    case kGraphicsElements
    case kGraphicsReferencingElements
    case kLightSourceElements
    case kNeverRenderedElements
    case kPaintServerElements
    case kRenderableElements
    case kShapeElements
    case kStructuralElements
    case kTextContentElements
    case kTextContentChildElements
    case kUncategorizedElements
    case kDeprecatedElements
}

struct QySVGTag : Equatable {
    var rawValue:String
    var categories:[QySVGTagCategory]
    init(rawValue:String, categories:[QySVGTagCategory] = []) {
        self.rawValue = rawValue
        self.categories = categories
    }
    static func == (lhs: QySVGTag, rhs: QySVGTag) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    func had(category:QySVGTagCategory) -> Bool {
        return categories.contains(category)
    }
}

extension QySVGTag {
    static let  kA = QySVGTag(rawValue: "a",
                              categories: [.kContainerElements,.kRenderableElements])
    static let  kAnimate = QySVGTag(rawValue: "animate",
                                    categories: [.kAnimationElements])
    static let  kAnimateMotion = QySVGTag(rawValue: "animateMotion",
                                          categories: [.kAnimationElements])
    static let  kAnimateTransform = QySVGTag(rawValue: "animateTransform")
    static let  kCircle = QySVGTag(rawValue: "circle",
                                   categories: [.kBasicShapes, .kGraphicsElements, .kRenderableElements, .kShapeElements])
    static let  kClipPath = QySVGTag(rawValue: "clipPath",
                                     categories: [.kUncategorizedElements, .kNeverRenderedElements])
    static let  kColorProfile = QySVGTag(rawValue: "color-profile",
                                         categories: [.kUncategorizedElements])
    static let  kDefs = QySVGTag(rawValue: "defs",
                                 categories: [.kStructuralElements, .kContainerElements, .kNeverRenderedElements])
    static let  kDesc = QySVGTag(rawValue: "desc",
                                 categories: [.kDescriptiveElements])
    static let  kDiscard = QySVGTag(rawValue: "discard",
                                    categories: [.kAnimationElements])
    static let  kEllipse = QySVGTag(rawValue: "ellipse",
                                    categories: [.kBasicShapes, .kGraphicsElements, .kRenderableElements, .kShapeElements])
    static let  kFeBlend = QySVGTag(rawValue: "feBlend",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeColorMatrix = QySVGTag(rawValue: "feColorMatrix",
                                          categories: [.kFilterPrimitiveElements])
    static let  kFeComponentTransfer = QySVGTag(rawValue: "feComponentTransfer",
                                                categories: [.kFilterPrimitiveElements])
    static let  kFeComposite = QySVGTag(rawValue: "feComposite",
                                        categories: [.kFilterPrimitiveElements])
    static let  kFeConvolveMatrix = QySVGTag(rawValue: "feConvolveMatrix",
                                             categories: [.kFilterPrimitiveElements])
    static let  kFeDiffuseLighting = QySVGTag(rawValue: "feDiffuseLighting",
                                              categories: [.kFilterPrimitiveElements])
    static let  kFeDisplacementMap = QySVGTag(rawValue: "feDisplacementMap",
                                              categories: [.kFilterPrimitiveElements])
    static let  kFeDistantLight = QySVGTag(rawValue: "feDistantLight",
                                           categories: [.kFilterPrimitiveElements])
    static let  kFeDropShadow = QySVGTag(rawValue: "feDropShadow",
                                         categories: [.kFilterPrimitiveElements])
    static let  kFeFlood = QySVGTag(rawValue: "feFlood",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeFuncA = QySVGTag(rawValue: "feFuncA",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeFuncB = QySVGTag(rawValue: "feFuncB",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeFuncG = QySVGTag(rawValue: "feFuncG",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeFuncR = QySVGTag(rawValue: "feFuncR",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeGaussianBlur = QySVGTag(rawValue: "feGaussianBlur",
                                           categories: [.kFilterPrimitiveElements])
    static let  kFeImage = QySVGTag(rawValue: "feImage",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeMerge = QySVGTag(rawValue: "feMerge",
                                    categories: [.kFilterPrimitiveElements])
    static let  kFeMergeNode = QySVGTag(rawValue: "feMergeNode",
                                        categories: [.kFilterPrimitiveElements])
    static let  kFeMorphology = QySVGTag(rawValue: "feMorphology",
                                         categories: [.kFilterPrimitiveElements])
    static let  kFeOffset = QySVGTag(rawValue: "feOffset", categories: [.kFilterPrimitiveElements])
    static let  kFePointLight = QySVGTag(rawValue: "fePointLight",
                                         categories: [.kFilterPrimitiveElements])
    static let  kFeSpecularLighting = QySVGTag(rawValue: "feSpecularLighting",
                                               categories: [.kFilterPrimitiveElements])
    static let  kFeSpotLight = QySVGTag(rawValue: "feSpotLight",
                                        categories: [.kFilterPrimitiveElements])
    static let  kFeTile = QySVGTag(rawValue: "feTile",
                                   categories: [.kFilterPrimitiveElements])
    static let  kFeTurbulence = QySVGTag(rawValue: "feTurbulence",
                                         categories: [.kFilterPrimitiveElements])
    static let  kFilter = QySVGTag(rawValue: "filter", categories: [.kUncategorizedElements])
    static let  kForeignObject = QySVGTag(rawValue: "foreignObject",
                                          categories: [.kUncategorizedElements, .kRenderableElements])
    static let  kG = QySVGTag(rawValue: "g",
                              categories: [.kStructuralElements, .kRenderableElements, .kContainerElements])
    static let  kHatch = QySVGTag(rawValue: "hatch",
                                  categories: [.kNeverRenderedElements, .kPaintServerElements])
    static let  kHatchpath = QySVGTag(rawValue: "hatchpath",
                                      categories: [.kUncategorizedElements])
    static let  kImage = QySVGTag(rawValue: "image",
                                  categories: [.kGraphicsElements, .kRenderableElements])
    static let  kLine = QySVGTag(rawValue: "line",
                                 categories: [.kRenderableElements, .kShapeElements, .kBasicShapes, .kGraphicsElements])
    static let  kLinearGradient = QySVGTag(rawValue: "linearGradient",
                                           categories: [.kGradientElements, .kNeverRenderedElements, .kPaintServerElements])
    static let  kMarker = QySVGTag(rawValue: "marker",
                                   categories: [.kNeverRenderedElements, .kContainerElements])
    static let  kMask = QySVGTag(rawValue: "mask",
                                 categories: [.kContainerElements, .kNeverRenderedElements])
    static let  kMetadata = QySVGTag(rawValue: "metadata",
                                     categories: [.kNeverRenderedElements, .kDescriptiveElements])
    static let  kMpath = QySVGTag(rawValue: "mpath",
                                  categories: [.kAnimationElements])
    static let  kPath = QySVGTag(rawValue: "path",
                                 categories: [.kGradientElements, .kRenderableElements, .kShapeElements])
    static let  kPattern = QySVGTag(rawValue: "pattern",
                                    categories: [.kNeverRenderedElements, .kPaintServerElements, .kContainerElements])
    static let  kPolygon = QySVGTag(rawValue: "polygon",
                                    categories: [.kBasicShapes, .kGraphicsElements, .kRenderableElements, .kShapeElements])
    static let  kPolyline = QySVGTag(rawValue: "polyline",
                                     categories: [.kRenderableElements, .kShapeElements, .kBasicShapes, .kGraphicsElements,])
    static let  kRadialGradient = QySVGTag(rawValue: "radialGradient",
                                           categories: [.kGradientElements, .kNeverRenderedElements, .kPaintServerElements])
    static let  kRect = QySVGTag(rawValue: "rect",
                                 categories: [.kRenderableElements, .kShapeElements, .kBasicShapes, .kGraphicsElements])
    static let  kScript = QySVGTag(rawValue: "script",
                                   categories: [.kNeverRenderedElements, .kUncategorizedElements])
    static let  kSet = QySVGTag(rawValue: "set",
                                categories: [.kAnimationElements])
    static let  kSolidcolor = QySVGTag(rawValue: "solidcolor",
                                       categories: [.kPaintServerElements])
    static let  kStop = QySVGTag(rawValue: "stop",
                                 categories: [.kGradientElements])
    static let  kStyle = QySVGTag(rawValue: "style",
                                  categories: [.kNeverRenderedElements, .kUncategorizedElements])
    static let  kSvg = QySVGTag(rawValue: "svg",
                                categories: [.kStructuralElements, .kContainerElements, .kRenderableElements])
    static let  kSwitch = QySVGTag(rawValue: "switch",
                                   categories: [.kRenderableElements, .kContainerElements])
    static let  kSymbol = QySVGTag(rawValue: "symbol",
                                   categories: [.kContainerElements, .kNeverRenderedElements, .kRenderableElements, .kStructuralElements])
    static let  kText = QySVGTag(rawValue: "text",
                                 categories: [.kGradientElements, .kRenderableElements, .kTextContentElements])
    static let  kTextPath = QySVGTag(rawValue: "textPath",
                                     categories: [.kRenderableElements, .kTextContentElements, .kTextContentChildElements])
    static let  kTitle = QySVGTag(rawValue: "title",
                                  categories: [.kDescriptiveElements, .kNeverRenderedElements])
    static let  kTspan = QySVGTag(rawValue: "tspan",
                                  categories: [.kRenderableElements, .kTextContentElements, .kTextContentChildElements])
    static let  kUse = QySVGTag(rawValue: "use",
                                categories: [.kGraphicsElements, .kGraphicsReferencingElements, .kRenderableElements, .kStructuralElements])
    static let  kView = QySVGTag(rawValue: "view",
                                 categories: [.kUncategorizedElements])
    static let  kUnknown = QySVGTag(rawValue: "unknown",
                                    categories: [.kContainerElements, .kRenderableElements])
    
    //MARK:- Obsolete and deprecated elements
    static let  kAltGlyph = QySVGTag(rawValue: "altGlyph", categories: [.kDeprecatedElements])
    static let  kAltGlyphDef = QySVGTag(rawValue: "altGlyphDef", categories: [.kDeprecatedElements])
    static let  kAltGlyphItem = QySVGTag(rawValue: "altGlyphItem", categories: [.kDeprecatedElements])
    static let  kAnimateColor = QySVGTag(rawValue: "animateColor", categories: [.kDeprecatedElements])
    static let  kCursor = QySVGTag(rawValue: "cursor", categories: [.kDeprecatedElements])
    static let  kFont = QySVGTag(rawValue: "font", categories: [.kDeprecatedElements])
    static let  kFontFace = QySVGTag(rawValue: "font-face", categories: [.kDeprecatedElements])
    static let  kFontFaceFormat = QySVGTag(rawValue: "font-face-format", categories: [.kDeprecatedElements])
    static let  kFontFaceName = QySVGTag(rawValue: "font-face-name", categories: [.kDeprecatedElements])
    static let  kFontFaceSrc = QySVGTag(rawValue: "font-face-src", categories: [.kDeprecatedElements])
    static let  kFontFaceUri = QySVGTag(rawValue: "font-face-uri", categories: [.kDeprecatedElements])
    static let  kGlyph = QySVGTag(rawValue: "glyph", categories: [.kDeprecatedElements])
    static let  kGlyphRef = QySVGTag(rawValue: "glyphRef", categories: [.kDeprecatedElements])
    static let  kHkern = QySVGTag(rawValue: "hkern", categories: [.kDeprecatedElements])
    static let  kMissingGlyph = QySVGTag(rawValue: "missing-glyph", categories: [.kDeprecatedElements])
    static let  kTref = QySVGTag(rawValue: "tref", categories: [.kDeprecatedElements])
    static let  kVkern = QySVGTag(rawValue: "vkern", categories: [.kDeprecatedElements])
}

extension QySVGTag {
    static let alls:[QySVGTag] = [kA,kAnimate,kAnimateMotion,kAnimateTransform,kCircle,kClipPath,kColorProfile,kDefs,kDesc,kDiscard,kEllipse,kFeBlend,kFeColorMatrix,kFeComponentTransfer,kFeComposite,kFeConvolveMatrix,kFeDiffuseLighting,kFeDisplacementMap,kFeDistantLight,kFeDropShadow,kFeFlood,kFeFuncA,kFeFuncB,kFeFuncG,kFeFuncR,kFeGaussianBlur,kFeImage,kFeMerge,kFeMergeNode,kFeMorphology,kFeOffset,kFePointLight,kFeSpecularLighting,kFeSpotLight,kFeTile,kFeTurbulence,kFilter,kForeignObject,kG,kHatch,kHatchpath,kImage,kLine,kLinearGradient,kMarker,kMask,kMetadata,kMpath,kPath,kPattern,kPolygon,kPolyline,kRadialGradient,kRect,kScript,kSet,kSolidcolor,kStop,kStyle,kSvg,kSwitch,kSymbol,kText,kTextPath,kTitle,kTspan,kUnknown,kUse,kView,kAltGlyph,kAltGlyphDef,kAltGlyphItem,kAnimateColor,kCursor,kFont,kFontFace,kFontFaceFormat,kFontFaceName,kFontFaceSrc,kFontFaceUri,kGlyph,kGlyphRef,kHkern,kMissingGlyph,kTref,kVkern]
    
    static func getTag(withRawValue rawValue:String) -> QySVGTag{
        if let tag = QySVGTag.alls.filter({$0.rawValue == rawValue}).first { return tag }
        else { return QySVGTag.kUnknown }
    }
}
