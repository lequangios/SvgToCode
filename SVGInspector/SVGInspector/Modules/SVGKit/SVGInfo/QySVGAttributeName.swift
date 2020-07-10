//
//  QySVGAttributeName.swift
//  SVG2Code
//
//  Created by Le Quang on 6/18/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation

struct QySVGAttributeName : Equatable {
    var rawValue:String
    init(rawValue:String) {
        self.rawValue = rawValue
    }
    static func == (lhs: QySVGAttributeName, rhs: QySVGAttributeName) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
    static let pattern = "(accent-height=|accent-height:|accumulate=|accumulate:|additive=|additive:|alignment-baseline=|alignment-baseline:|allowReorder=|allowReorder:|alphabetic=|alphabetic:|amplitude=|amplitude:|arabic-form=|arabic-form:|ascent=|ascent:|attributeName=|attributeName:|attributeType=|attributeType:|autoReverse=|autoReverse:|azimuth=|azimuth:|baseFrequency=|baseFrequency:|baseline-shift=|baseline-shift:|baseProfile=|baseProfile:|bbox=|bbox:|begin=|begin:|bias=|bias:|by=|by:|calcMode=|calcMode:|cap-height=|cap-height:|class=|class:|clip=|clip:|clipPathUnits=|clipPathUnits:|clip-path=|clip-path:|clip-rule=|clip-rule:|color=|color:|color-interpolation=|color-interpolation:|color-interpolation-filters=|color-interpolation-filters:|color-profile=|color-profile:|color-rendering=|color-rendering:|contentScriptType=|contentScriptType:|contentStyleType=|contentStyleType:|cursor=|cursor:|cx=|cx:|cy=|cy:|d=|d:|decelerate=|decelerate:|descent=|descent:|diffuseConstant=|diffuseConstant:|direction=|direction:|display=|display:|divisor=|divisor:|dominant-baseline=|dominant-baseline:|dur=|dur:|dx=|dx:|dy=|dy:|edgeMode=|edgeMode:|elevation=|elevation:|enable-background=|enable-background:|end=|end:|exponent=|exponent:|externalResourcesRequired=|externalResourcesRequired:|fill=|fill:|fill-opacity=|fill-opacity:|fill-rule=|fill-rule:|filter=|filter:|filterRes=|filterRes:|filterUnits=|filterUnits:|flood-color=|flood-color:|flood-opacity=|flood-opacity:|font-family=|font-family:|font-size=|font-size:|font-size-adjust=|font-size-adjust:|font-stretch=|font-stretch:|font-style=|font-style:|font-variant=|font-variant:|font-weight=|font-weight:|format=|format:|from=|from:|fr=|fr:|fx=|fx:|fy=|fy:|g1=|g1:|g2=|g2:|glyph-name=|glyph-name:|glyph-orientation-horizontal=|glyph-orientation-horizontal:|glyph-orientation-vertical=|glyph-orientation-vertical:|glyphRef=|glyphRef:|gradientTransform=|gradientTransform:|gradientUnits=|gradientUnits:|hanging=|hanging:|height=|height:|href=|href:|hreflang=|hreflang:|horiz-adv-x=|horiz-adv-x:|horiz-origin-x=|horiz-origin-x:|id=|id:|ideographic=|ideographic:|image-rendering=|image-rendering:|in=|in:|in2=|in2:|intercept=|intercept:|k=|k:|k1=|k1:|k2=|k2:|k3=|k3:|k4=|k4:|kernelMatrix=|kernelMatrix:|kernelUnitLength=|kernelUnitLength:|kerning=|kerning:|keyPoints=|keyPoints:|keySplines=|keySplines:|keyTimes=|keyTimes:|lang=|lang:|lengthAdjust=|lengthAdjust:|letter-spacing=|letter-spacing:|lighting-color=|lighting-color:|limitingConeAngle=|limitingConeAngle:|local=|local:|marker-end=|marker-end:|marker-mid=|marker-mid:|marker-start=|marker-start:|markerHeight=|markerHeight:|markerUnits=|markerUnits:|markerWidth=|markerWidth:|mask=|mask:|maskContentUnits=|maskContentUnits:|maskUnits=|maskUnits:|mathematical=|mathematical:|max=|max:|media=|media:|method=|method:|min=|min:|mode=|mode:|name=|name:|numOctaves=|numOctaves:|offset=|offset:|opacity=|opacity:|operator=|operator:|order=|order:|orient=|orient:|orientation=|orientation:|origin=|origin:|overflow=|overflow:|overline-position=|overline-position:|overline-thickness=|overline-thickness:|panose-1=|panose-1:|paint-order=|paint-order:|path=|path:|pathLength=|pathLength:|patternContentUnits=|patternContentUnits:|patternTransform=|patternTransform:|patternUnits=|patternUnits:|ping=|ping:|pointer-events=|pointer-events:|points=|points:|pointsAtX=|pointsAtX:|pointsAtY=|pointsAtY:|pointsAtZ=|pointsAtZ:|preserveAlpha=|preserveAlpha:|preserveAspectRatio=|preserveAspectRatio:|primitiveUnits=|primitiveUnits:|r=|r:|radius=|radius:|referrerPolicy=|referrerPolicy:|refX=|refX:|refY=|refY:|rel=|rel:|rendering-intent=|rendering-intent:|repeatCount=|repeatCount:|repeatDur=|repeatDur:|requiredExtensions=|requiredExtensions:|requiredFeatures=|requiredFeatures:|restart=|restart:|result=|result:|rotate=|rotate:|rx=|rx:|ry=|ry:|scale=|scale:|seed=|seed:|shape-rendering=|shape-rendering:|slope=|slope:|spacing=|spacing:|specularConstant=|specularConstant:|specularExponent=|specularExponent:|speed=|speed:|spreadMethod=|spreadMethod:|startOffset=|startOffset:|stdDeviation=|stdDeviation:|stemh=|stemh:|stemv=|stemv:|stitchTiles=|stitchTiles:|stop-color=|stop-color:|stop-opacity=|stop-opacity:|strikethrough-position=|strikethrough-position:|strikethrough-thickness=|strikethrough-thickness:|string=|string:|stroke=|stroke:|stroke-dasharray=|stroke-dasharray:|stroke-dashoffset=|stroke-dashoffset:|stroke-linecap=|stroke-linecap:|stroke-linejoin=|stroke-linejoin:|stroke-miterlimit=|stroke-miterlimit:|stroke-opacity=|stroke-opacity:|stroke-width=|stroke-width:|style=|style:|surfaceScale=|surfaceScale:|systemLanguage=|systemLanguage:|tabindex=|tabindex:|tableValues=|tableValues:|target=|target:|targetX=|targetX:|targetY=|targetY:|text-anchor=|text-anchor:|text-decoration=|text-decoration:|text-rendering=|text-rendering:|textLength=|textLength:|to=|to:|transform=|transform:|transform-origin=|transform-origin:|type=|type:|u1=|u1:|u2=|u2:|underline-position=|underline-position:|underline-thickness=|underline-thickness:|unicode=|unicode:|unicode-bidi=|unicode-bidi:|unicode-range=|unicode-range:|units-per-em=|units-per-em:|v-alphabetic=|v-alphabetic:|v-hanging=|v-hanging:|v-ideographic=|v-ideographic:|v-mathematical=|v-mathematical:|values=|values:|vector-effect=|vector-effect:|version=|version:|vert-adv-y=|vert-adv-y:|vert-origin-x=|vert-origin-x:|vert-origin-y=|vert-origin-y:|viewBox=|viewBox:|viewTarget=|viewTarget:|visibility=|visibility:|width=|width:|widths=|widths:|word-spacing=|word-spacing:|writing-mode=|writing-mode:|x=|x:|x-height=|x-height:|x1=|x1:|x2=|x2:|xChannelSelector=|xChannelSelector:|xlink:actuate=|xlink:actuate:|xlink:arcrole=|xlink:arcrole:|xlink:href=|xlink:href:|xlink:role=|xlink:role:|xlink:show=|xlink:show:|xlink:title=|xlink:title:|xlink:type=|xlink:type:|xml:base=|xml:base:|xml:lang=|xml:lang:|xml:space=|xml:space:|y=|y:|y1=|y1:|y2=|y2:|yChannelSelector=|yChannelSelector:|z=|z:|zoomAndPan=|zoomAndPan:)"
}

extension QySVGAttributeName {
    static let kAccelerate:QySVGAttributeName = .init(rawValue: "accelerate")
    static let kAccentHeight:QySVGAttributeName = .init(rawValue: "accent-height")
    static let kAccumulate:QySVGAttributeName = .init(rawValue: "accumulate")
    static let kAdditive:QySVGAttributeName = .init(rawValue: "additive")
    static let kAlignmentBaseline:QySVGAttributeName = .init(rawValue: "alignment-baseline")
    static let kAllowReorder:QySVGAttributeName = .init(rawValue: "allowReorder")
    static let kAlphabetic:QySVGAttributeName = .init(rawValue: "alphabetic")
    static let kAmplitude:QySVGAttributeName = .init(rawValue: "amplitude")
    static let kArabicForm:QySVGAttributeName = .init(rawValue: "arabic-form")
    static let kAscent:QySVGAttributeName = .init(rawValue: "ascent")
    static let kAttributeName:QySVGAttributeName = .init(rawValue: "attributeName")
    static let kAttributeType:QySVGAttributeName = .init(rawValue: "attributeType")
    static let kAutoReverse:QySVGAttributeName = .init(rawValue: "autoReverse")
    static let kAzimuth:QySVGAttributeName = .init(rawValue: "azimuth")
    static let kBaseFrequency:QySVGAttributeName = .init(rawValue: "baseFrequency")
    static let kBaselineShift:QySVGAttributeName = .init(rawValue: "baseline-shift")
    static let kBaseProfile:QySVGAttributeName = .init(rawValue: "baseProfile")
    static let kBbox:QySVGAttributeName = .init(rawValue: "bbox")
    static let kBegin:QySVGAttributeName = .init(rawValue: "begin")
    static let kBias:QySVGAttributeName = .init(rawValue: "bias")
    static let kBy:QySVGAttributeName = .init(rawValue: "by")
    static let kCalcMode:QySVGAttributeName = .init(rawValue: "calcMode")
    static let kCapHeight:QySVGAttributeName = .init(rawValue: "cap-height")
    static let kClass:QySVGAttributeName = .init(rawValue: "class")
    static let kClip:QySVGAttributeName = .init(rawValue: "clip")
    static let kClipPathUnits:QySVGAttributeName = .init(rawValue: "clipPathUnits")
    static let kClipPath:QySVGAttributeName = .init(rawValue: "clip-path")
    static let kClipRule:QySVGAttributeName = .init(rawValue: "clip-rule")
    static let kColor:QySVGAttributeName = .init(rawValue: "color")
    static let kColorInterpolation:QySVGAttributeName = .init(rawValue: "color-interpolation")
    static let kColorInterpolationFilters:QySVGAttributeName = .init(rawValue: "color-interpolation-filters")
    static let kColorProfile:QySVGAttributeName = .init(rawValue: "color-profile")
    static let kColorRendering:QySVGAttributeName = .init(rawValue: "color-rendering")
    static let kContentScriptType:QySVGAttributeName = .init(rawValue: "contentScriptType")
    static let kContentStyleType:QySVGAttributeName = .init(rawValue: "contentStyleType")
    static let kCursor:QySVGAttributeName = .init(rawValue: "cursor")
    static let kCx:QySVGAttributeName = .init(rawValue: "cx")
    static let kCy:QySVGAttributeName = .init(rawValue: "cy")
    static let kD:QySVGAttributeName = .init(rawValue: "d")
    static let kDecelerate:QySVGAttributeName = .init(rawValue: "decelerate")
    static let kDescent:QySVGAttributeName = .init(rawValue: "descent")
    static let kDiffuseConstant:QySVGAttributeName = .init(rawValue: "diffuseConstant")
    static let kDirection:QySVGAttributeName = .init(rawValue: "direction")
    static let kDisplay:QySVGAttributeName = .init(rawValue: "display")
    static let kDivisor:QySVGAttributeName = .init(rawValue: "divisor")
    static let kDominantBaseline:QySVGAttributeName = .init(rawValue: "dominant-baseline")
    static let kDur:QySVGAttributeName = .init(rawValue: "dur")
    static let kDx:QySVGAttributeName = .init(rawValue: "dx")
    static let kDy:QySVGAttributeName = .init(rawValue: "dy")
    static let kEdgeMode:QySVGAttributeName = .init(rawValue: "edgeMode")
    static let kElevation:QySVGAttributeName = .init(rawValue: "elevation")
    static let kEnableBackground:QySVGAttributeName = .init(rawValue: "enable-background")
    static let kEnd:QySVGAttributeName = .init(rawValue: "end")
    static let kExponent:QySVGAttributeName = .init(rawValue: "exponent")
    static let kExternalResourcesRequired:QySVGAttributeName = .init(rawValue: "externalResourcesRequired")
    static let kFill:QySVGAttributeName = .init(rawValue: "fill")
    static let kFillOpacity:QySVGAttributeName = .init(rawValue: "fill-opacity")
    static let kFillRule:QySVGAttributeName = .init(rawValue: "fill-rule")
    static let kFilter:QySVGAttributeName = .init(rawValue: "filter")
    static let kFilterRes:QySVGAttributeName = .init(rawValue: "filterRes")
    static let kFilterUnits:QySVGAttributeName = .init(rawValue: "filterUnits")
    static let kFloodColor:QySVGAttributeName = .init(rawValue: "flood-color")
    static let kFloodOpacity:QySVGAttributeName = .init(rawValue: "flood-opacity")
    static let kFontFamily:QySVGAttributeName = .init(rawValue: "font-family")
    static let kFontSize:QySVGAttributeName = .init(rawValue: "font-size")
    static let kFontSizeAdjust:QySVGAttributeName = .init(rawValue: "font-size-adjust")
    static let kFontStretch:QySVGAttributeName = .init(rawValue: "font-stretch")
    static let kFontStyle:QySVGAttributeName = .init(rawValue: "font-style")
    static let kFontVariant:QySVGAttributeName = .init(rawValue: "font-variant")
    static let kFontWeight:QySVGAttributeName = .init(rawValue: "font-weight")
    static let kFormat:QySVGAttributeName = .init(rawValue: "format")
    static let kFrom:QySVGAttributeName = .init(rawValue: "from")
    static let kFr:QySVGAttributeName = .init(rawValue: "fr")
    static let kFx:QySVGAttributeName = .init(rawValue: "fx")
    static let kFy:QySVGAttributeName = .init(rawValue: "fy")
    static let kG1:QySVGAttributeName = .init(rawValue: "g1")
    static let kG2:QySVGAttributeName = .init(rawValue: "g2")
    static let kGlyphName:QySVGAttributeName = .init(rawValue: "glyph-name")
    static let kGlyphOrientationHorizontal:QySVGAttributeName = .init(rawValue: "glyph-orientation-horizontal")
    static let kGlyphOrientationVertical:QySVGAttributeName = .init(rawValue: "glyph-orientation-vertical")
    static let kGlyphRef:QySVGAttributeName = .init(rawValue: "glyphRef")
    static let kGradientTransform:QySVGAttributeName = .init(rawValue: "gradientTransform")
    static let kGradientUnits:QySVGAttributeName = .init(rawValue: "gradientUnits")
    static let kHanging:QySVGAttributeName = .init(rawValue: "hanging")
    static let kHeight:QySVGAttributeName = .init(rawValue: "height")
    static let kHref:QySVGAttributeName = .init(rawValue: "href")
    static let kHreflang:QySVGAttributeName = .init(rawValue: "hreflang")
    static let kHorizAdvX:QySVGAttributeName = .init(rawValue: "horiz-adv-x")
    static let kHorizOriginX:QySVGAttributeName = .init(rawValue: "horiz-origin-x")
    static let kId:QySVGAttributeName = .init(rawValue: "id")
    static let kIdeographic:QySVGAttributeName = .init(rawValue: "ideographic")
    static let kImageRendering:QySVGAttributeName = .init(rawValue: "image-rendering")
    static let kIn:QySVGAttributeName = .init(rawValue: "in")
    static let kIn2:QySVGAttributeName = .init(rawValue: "in2")
    static let kIntercept:QySVGAttributeName = .init(rawValue: "intercept")
    static let kK:QySVGAttributeName = .init(rawValue: "k")
    static let kK1:QySVGAttributeName = .init(rawValue: "k1")
    static let kK2:QySVGAttributeName = .init(rawValue: "k2")
    static let kK3:QySVGAttributeName = .init(rawValue: "k3")
    static let kK4:QySVGAttributeName = .init(rawValue: "k4")
    static let kKernelMatrix:QySVGAttributeName = .init(rawValue: "kernelMatrix")
    static let kKernelUnitLength:QySVGAttributeName = .init(rawValue: "kernelUnitLength")
    static let kKerning:QySVGAttributeName = .init(rawValue: "kerning")
    static let kKeyPoints:QySVGAttributeName = .init(rawValue: "keyPoints")
    static let kKeySplines:QySVGAttributeName = .init(rawValue: "keySplines")
    static let kKeyTimes:QySVGAttributeName = .init(rawValue: "keyTimes")
    static let kLang:QySVGAttributeName = .init(rawValue: "lang")
    static let kLengthAdjust:QySVGAttributeName = .init(rawValue: "lengthAdjust")
    static let kLetterSpacing:QySVGAttributeName = .init(rawValue: "letter-spacing")
    static let kLightingColor:QySVGAttributeName = .init(rawValue: "lighting-color")
    static let kLimitingConeAngle:QySVGAttributeName = .init(rawValue: "limitingConeAngle")
    static let kLocal:QySVGAttributeName = .init(rawValue: "local")
    static let kMarkerEnd:QySVGAttributeName = .init(rawValue: "marker-end")
    static let kMarkerMid:QySVGAttributeName = .init(rawValue: "marker-mid")
    static let kMarkerStart:QySVGAttributeName = .init(rawValue: "marker-start")
    static let kMarkerHeight:QySVGAttributeName = .init(rawValue: "markerHeight")
    static let kMarkerUnits:QySVGAttributeName = .init(rawValue: "markerUnits")
    static let kMarkerWidth:QySVGAttributeName = .init(rawValue: "markerWidth")
    static let kMask:QySVGAttributeName = .init(rawValue: "mask")
    static let kMaskContentUnits:QySVGAttributeName = .init(rawValue: "maskContentUnits")
    static let kMaskUnits:QySVGAttributeName = .init(rawValue: "maskUnits")
    static let kMathematical:QySVGAttributeName = .init(rawValue: "mathematical")
    static let kMax:QySVGAttributeName = .init(rawValue: "max")
    static let kMedia:QySVGAttributeName = .init(rawValue: "media")
    static let kMethod:QySVGAttributeName = .init(rawValue: "method")
    static let kMin:QySVGAttributeName = .init(rawValue: "min")
    static let kMode:QySVGAttributeName = .init(rawValue: "mode")
    static let kName:QySVGAttributeName = .init(rawValue: "name")
    static let kNumOctaves:QySVGAttributeName = .init(rawValue: "numOctaves")
    static let kOffset:QySVGAttributeName = .init(rawValue: "offset")
    static let kOpacity:QySVGAttributeName = .init(rawValue: "opacity")
    static let kOperator:QySVGAttributeName = .init(rawValue: "operator")
    static let kOrder:QySVGAttributeName = .init(rawValue: "order")
    static let kOrient:QySVGAttributeName = .init(rawValue: "orient")
    static let kOrientation:QySVGAttributeName = .init(rawValue: "orientation")
    static let kOrigin:QySVGAttributeName = .init(rawValue: "origin")
    static let kOverflow:QySVGAttributeName = .init(rawValue: "overflow")
    static let kOverlinePosition:QySVGAttributeName = .init(rawValue: "overline-position")
    static let kOverlineThickness:QySVGAttributeName = .init(rawValue: "overline-thickness")
    static let kPanose1:QySVGAttributeName = .init(rawValue: "panose-1")
    static let kPaintOrder:QySVGAttributeName = .init(rawValue: "paint-order")
    static let kPath:QySVGAttributeName = .init(rawValue: "path")
    static let kPathLength:QySVGAttributeName = .init(rawValue: "pathLength")
    static let kPatternContentUnits:QySVGAttributeName = .init(rawValue: "patternContentUnits")
    static let kPatternTransform:QySVGAttributeName = .init(rawValue: "patternTransform")
    static let kPatternUnits:QySVGAttributeName = .init(rawValue: "patternUnits")
    static let kPing:QySVGAttributeName = .init(rawValue: "ping")
    static let kPointerEvents:QySVGAttributeName = .init(rawValue: "pointer-events")
    static let kPoints:QySVGAttributeName = .init(rawValue: "points")
    static let kPointsAtX:QySVGAttributeName = .init(rawValue: "pointsAtX")
    static let kPointsAtY:QySVGAttributeName = .init(rawValue: "pointsAtY")
    static let kPointsAtZ:QySVGAttributeName = .init(rawValue: "pointsAtZ")
    static let kPreserveAlpha:QySVGAttributeName = .init(rawValue: "preserveAlpha")
    static let kPreserveAspectRatio:QySVGAttributeName = .init(rawValue: "preserveAspectRatio")
    static let kPrimitiveUnits:QySVGAttributeName = .init(rawValue: "primitiveUnits")
    static let kR:QySVGAttributeName = .init(rawValue: "r")
    static let kRadius:QySVGAttributeName = .init(rawValue: "radius")
    static let kReferrerPolicy:QySVGAttributeName = .init(rawValue: "referrerPolicy")
    static let kRefX:QySVGAttributeName = .init(rawValue: "refX")
    static let kRefY:QySVGAttributeName = .init(rawValue: "refY")
    static let kRel:QySVGAttributeName = .init(rawValue: "rel")
    static let kRenderingIntent:QySVGAttributeName = .init(rawValue: "rendering-intent")
    static let kRepeatCount:QySVGAttributeName = .init(rawValue: "repeatCount")
    static let kRepeatDur:QySVGAttributeName = .init(rawValue: "repeatDur")
    static let kRequiredExtensions:QySVGAttributeName = .init(rawValue: "requiredExtensions")
    static let kRequiredFeatures:QySVGAttributeName = .init(rawValue: "requiredFeatures")
    static let kRestart:QySVGAttributeName = .init(rawValue: "restart")
    static let kResult:QySVGAttributeName = .init(rawValue: "result")
    static let kRotate:QySVGAttributeName = .init(rawValue: "rotate")
    static let kRx:QySVGAttributeName = .init(rawValue: "rx")
    static let kRy:QySVGAttributeName = .init(rawValue: "ry")
    static let kScale:QySVGAttributeName = .init(rawValue: "scale")
    static let kSeed:QySVGAttributeName = .init(rawValue: "seed")
    static let kShapeRendering:QySVGAttributeName = .init(rawValue: "shape-rendering")
    static let kSlope:QySVGAttributeName = .init(rawValue: "slope")
    static let kSpacing:QySVGAttributeName = .init(rawValue: "spacing")
    static let kSpecularConstant:QySVGAttributeName = .init(rawValue: "specularConstant")
    static let kSpecularExponent:QySVGAttributeName = .init(rawValue: "specularExponent")
    static let kSpeed:QySVGAttributeName = .init(rawValue: "speed")
    static let kSpreadMethod:QySVGAttributeName = .init(rawValue: "spreadMethod")
    static let kStartOffset:QySVGAttributeName = .init(rawValue: "startOffset")
    static let kStdDeviation:QySVGAttributeName = .init(rawValue: "stdDeviation")
    static let kStemh:QySVGAttributeName = .init(rawValue: "stemh")
    static let kStemv:QySVGAttributeName = .init(rawValue: "stemv")
    static let kStitchTiles:QySVGAttributeName = .init(rawValue: "stitchTiles")
    static let kStopColor:QySVGAttributeName = .init(rawValue: "stop-color")
    static let kStopOpacity:QySVGAttributeName = .init(rawValue: "stop-opacity")
    static let kStrikethroughPosition:QySVGAttributeName = .init(rawValue: "strikethrough-position")
    static let kStrikethroughThickness:QySVGAttributeName = .init(rawValue: "strikethrough-thickness")
    static let kString:QySVGAttributeName = .init(rawValue: "string")
    static let kStroke:QySVGAttributeName = .init(rawValue: "stroke")
    static let kStrokeDasharray:QySVGAttributeName = .init(rawValue: "stroke-dasharray")
    static let kStrokeDashoffset:QySVGAttributeName = .init(rawValue: "stroke-dashoffset")
    static let kStrokeLinecap:QySVGAttributeName = .init(rawValue: "stroke-linecap")
    static let kStrokeLinejoin:QySVGAttributeName = .init(rawValue: "stroke-linejoin")
    static let kStrokeMiterlimit:QySVGAttributeName = .init(rawValue: "stroke-miterlimit")
    static let kStrokeOpacity:QySVGAttributeName = .init(rawValue: "stroke-opacity")
    static let kStrokeWidth:QySVGAttributeName = .init(rawValue: "stroke-width")
    static let kStyle:QySVGAttributeName = .init(rawValue: "style")
    static let kSurfaceScale:QySVGAttributeName = .init(rawValue: "surfaceScale")
    static let kSystemLanguage:QySVGAttributeName = .init(rawValue: "systemLanguage")
    static let kTabindex:QySVGAttributeName = .init(rawValue: "tabindex")
    static let kTableValues:QySVGAttributeName = .init(rawValue: "tableValues")
    static let kTarget:QySVGAttributeName = .init(rawValue: "target")
    static let kTargetX:QySVGAttributeName = .init(rawValue: "targetX")
    static let kTargetY:QySVGAttributeName = .init(rawValue: "targetY")
    static let kTextAnchor:QySVGAttributeName = .init(rawValue: "text-anchor")
    static let kTextDecoration:QySVGAttributeName = .init(rawValue: "text-decoration")
    static let kTextRendering:QySVGAttributeName = .init(rawValue: "text-rendering")
    static let kTextLength:QySVGAttributeName = .init(rawValue: "textLength")
    static let kTo:QySVGAttributeName = .init(rawValue: "to")
    static let kTransform:QySVGAttributeName = .init(rawValue: "transform")
    static let kTransformOrigin:QySVGAttributeName = .init(rawValue: "transform-origin")
    static let kType:QySVGAttributeName = .init(rawValue: "type")
    static let kU1:QySVGAttributeName = .init(rawValue: "u1")
    static let kU2:QySVGAttributeName = .init(rawValue: "u2")
    static let kUnderlinePosition:QySVGAttributeName = .init(rawValue: "underline-position")
    static let kUnderlineThickness:QySVGAttributeName = .init(rawValue: "underline-thickness")
    static let kUnicode:QySVGAttributeName = .init(rawValue: "unicode")
    static let kUnicodeBidi:QySVGAttributeName = .init(rawValue: "unicode-bidi")
    static let kUnicodeRange:QySVGAttributeName = .init(rawValue: "unicode-range")
    static let kUnitsPerEm:QySVGAttributeName = .init(rawValue: "units-per-em")
    static let kVAlphabetic:QySVGAttributeName = .init(rawValue: "v-alphabetic")
    static let kVHanging:QySVGAttributeName = .init(rawValue: "v-hanging")
    static let kVIdeographic:QySVGAttributeName = .init(rawValue: "v-ideographic")
    static let kVMathematical:QySVGAttributeName = .init(rawValue: "v-mathematical")
    static let kValues:QySVGAttributeName = .init(rawValue: "values")
    static let kVectorEffect:QySVGAttributeName = .init(rawValue: "vector-effect")
    static let kVersion:QySVGAttributeName = .init(rawValue: "version")
    static let kVertAdvY:QySVGAttributeName = .init(rawValue: "vert-adv-y")
    static let kVertOriginX:QySVGAttributeName = .init(rawValue: "vert-origin-x")
    static let kVertOriginY:QySVGAttributeName = .init(rawValue: "vert-origin-y")
    static let kViewBox:QySVGAttributeName = .init(rawValue: "viewBox")
    static let kViewTarget:QySVGAttributeName = .init(rawValue: "viewTarget")
    static let kVisibility:QySVGAttributeName = .init(rawValue: "visibility")
    static let kWidth:QySVGAttributeName = .init(rawValue: "width")
    static let kWidths:QySVGAttributeName = .init(rawValue: "widths")
    static let kWordSpacing:QySVGAttributeName = .init(rawValue: "word-spacing")
    static let kWritingMode:QySVGAttributeName = .init(rawValue: "writing-mode")
    static let kX:QySVGAttributeName = .init(rawValue: "x")
    static let kXHeight:QySVGAttributeName = .init(rawValue: "x-height")
    static let kX1:QySVGAttributeName = .init(rawValue: "x1")
    static let kX2:QySVGAttributeName = .init(rawValue: "x2")
    static let kXChannelSelector:QySVGAttributeName = .init(rawValue: "xChannelSelector")
    static let kXlinkActuate:QySVGAttributeName = .init(rawValue: "xlink:actuate")
    static let kXlinkArcrole:QySVGAttributeName = .init(rawValue: "xlink:arcrole")
    static let kXlinkHref:QySVGAttributeName = .init(rawValue: "xlink:href")
    static let kXlinkRole:QySVGAttributeName = .init(rawValue: "xlink:role")
    static let kXlinkShow:QySVGAttributeName = .init(rawValue: "xlink:show")
    static let kXlinkTitle:QySVGAttributeName = .init(rawValue: "xlink:title")
    static let kXlinkType:QySVGAttributeName = .init(rawValue: "xlink:type")
    static let kXmlBase:QySVGAttributeName = .init(rawValue: "xml:base")
    static let kXmlLang:QySVGAttributeName = .init(rawValue: "xml:lang")
    static let kXmlSpace:QySVGAttributeName = .init(rawValue: "xml:space")
    static let kY:QySVGAttributeName = .init(rawValue: "y")
    static let kY1:QySVGAttributeName = .init(rawValue: "y1")
    static let kY2:QySVGAttributeName = .init(rawValue: "y2")
    static let kYChannelSelector:QySVGAttributeName = .init(rawValue: "yChannelSelector")
    static let kZ:QySVGAttributeName = .init(rawValue: "z")
    static let kZoomAndPan:QySVGAttributeName = .init(rawValue: "zoomAndPan")
    static let kUnknown:QySVGAttributeName = .init(rawValue: "unknown")
}

extension QySVGAttributeName {
    static let alls:[QySVGAttributeName] = [kAccentHeight,kAccumulate,kAdditive,kAlignmentBaseline,kAllowReorder,kAlphabetic,kAmplitude,kArabicForm,kAscent,kAttributeName,kAttributeType,kAutoReverse,kAzimuth,kBaseFrequency,kBaselineShift,kBaseProfile,kBbox,kBegin,kBias,kBy,kCalcMode,kCapHeight,kClass,kClip,kClipPathUnits,kClipPath,kClipRule,kColor,kColorInterpolation,kColorInterpolationFilters,kColorProfile,kColorRendering,kContentScriptType,kContentStyleType,kCursor,kCx,kCy,kD,kDecelerate,kDescent,kDiffuseConstant,kDirection,kDisplay,kDivisor,kDominantBaseline,kDur,kDx,kDy,kEdgeMode,kElevation,kEnableBackground,kEnd,kExponent,kExternalResourcesRequired,kFill,kFillOpacity,kFillRule,kFilter,kFilterRes,kFilterUnits,kFloodColor,kFloodOpacity,kFontFamily,kFontSize,kFontSizeAdjust,kFontStretch,kFontStyle,kFontVariant,kFontWeight,kFormat,kFrom,kFr,kFx,kFy,kG1,kG2,kGlyphName,kGlyphOrientationHorizontal,kGlyphOrientationVertical,kGlyphRef,kGradientTransform,kGradientUnits,kHanging,kHeight,kHref,kHreflang,kHorizAdvX,kHorizOriginX,kId,kIdeographic,kImageRendering,kIn,kIn2,kIntercept,kK,kK1,kK2,kK3,kK4,kKernelMatrix,kKernelUnitLength,kKerning,kKeyPoints,kKeySplines,kKeyTimes,kLang,kLengthAdjust,kLetterSpacing,kLightingColor,kLimitingConeAngle,kLocal,kMarkerEnd,kMarkerMid,kMarkerStart,kMarkerHeight,kMarkerUnits,kMarkerWidth,kMask,kMaskContentUnits,kMaskUnits,kMathematical,kMax,kMedia,kMethod,kMin,kMode,kName,kNumOctaves,kOffset,kOpacity,kOperator,kOrder,kOrient,kOrientation,kOrigin,kOverflow,kOverlinePosition,kOverlineThickness,kPanose1,kPaintOrder,kPath,kPathLength,kPatternContentUnits,kPatternTransform,kPatternUnits,kPing,kPointerEvents,kPoints,kPointsAtX,kPointsAtY,kPointsAtZ,kPreserveAlpha,kPreserveAspectRatio,kPrimitiveUnits,kR,kRadius,kReferrerPolicy,kRefX,kRefY,kRel,kRenderingIntent,kRepeatCount,kRepeatDur,kRequiredExtensions,kRequiredFeatures,kRestart,kResult,kRotate,kRx,kRy,kScale,kSeed,kShapeRendering,kSlope,kSpacing,kSpecularConstant,kSpecularExponent,kSpeed,kSpreadMethod,kStartOffset,kStdDeviation,kStemh,kStemv,kStitchTiles,kStopColor,kStopOpacity,kStrikethroughPosition,kStrikethroughThickness,kString,kStroke,kStrokeDasharray,kStrokeDashoffset,kStrokeLinecap,kStrokeLinejoin,kStrokeMiterlimit,kStrokeOpacity,kStrokeWidth,kStyle,kSurfaceScale,kSystemLanguage,kTabindex,kTableValues,kTarget,kTargetX,kTargetY,kTextAnchor,kTextDecoration,kTextRendering,kTextLength,kTo,kTransform,kTransformOrigin,kType,kU1,kU2,kUnderlinePosition,kUnderlineThickness,kUnicode,kUnicodeBidi,kUnicodeRange,kUnitsPerEm,kVAlphabetic,kVHanging,kVIdeographic,kVMathematical,kValues,kVectorEffect,kVersion,kVertAdvY,kVertOriginX,kVertOriginY,kViewBox,kViewTarget,kVisibility,kWidth,kWidths,kWordSpacing,kWritingMode,kX,kXHeight,kX1,kX2,kXChannelSelector,kXlinkActuate,kXlinkArcrole,kXlinkHref,kXlinkRole,kXlinkShow,kXlinkTitle,kXlinkType,kXmlBase,kXmlLang,kXmlSpace,kY,kY1,kY2,kYChannelSelector,kZ,kZoomAndPan]
    
    static func getAttributeName(withRawValue rawValue:String) -> QySVGAttributeName {
        if let name = QySVGAttributeName.alls.filter({$0.rawValue == rawValue}).first { return name }
        else { return QySVGAttributeName.kUnknown }
    }
}

struct QySVGAttributeNameCategory {
    static let coreAttributes:[QySVGAttributeName] = [.kId,.kLang,.kTabindex,.kXmlBase,.kXmlLang,.kXmlSpace]
    static let styleAttributes:[QySVGAttributeName] = [.kClass,.kStyle]
    static let conditionalProcessingAttributes:[QySVGAttributeName] = [.kExternalResourcesRequired,.kRequiredExtensions,.kRequiredFeatures,.kSystemLanguage]
    static let xLinkAttributes:[QySVGAttributeName] = [.kXlinkHref,.kXlinkType,.kXlinkRole,.kXlinkArcrole,.kXlinkTitle,.kXlinkShow,.kXlinkActuate]
    static let presentationAttributes:[QySVGAttributeName] = [.kAlignmentBaseline,.kBaselineShift,.kClip,.kClipPath,.kClipRule,.kColor,.kColorInterpolation,.kColorInterpolationFilters,.kColorProfile,.kColorRendering,.kCursor,.kDirection,.kDisplay,.kDominantBaseline,.kEnableBackground,.kFill,.kFillOpacity,.kFillRule,.kFilter,.kFloodColor,.kFloodOpacity,.kFontFamily,.kFontSize,.kFontSizeAdjust,.kFontStretch,.kFontStyle,.kFontVariant,.kFontWeight,.kGlyphOrientationHorizontal,.kGlyphOrientationVertical,.kImageRendering,.kKerning,.kLetterSpacing,.kLightingColor,.kMarkerEnd,.kMarkerMid,.kMarkerStart,.kMask,.kOpacity,.kOverflow,.kPointerEvents,.kShapeRendering,.kStopColor,.kStopOpacity,.kStroke,.kStrokeDasharray,.kStrokeDashoffset,.kStrokeLinecap,.kStrokeLinejoin,.kStrokeMiterlimit,.kStrokeOpacity,.kStrokeWidth,.kTextAnchor,.kTextDecoration,.kTextRendering,.kTransform,.kTransformOrigin,.kUnicodeBidi,.kVectorEffect,.kVisibility,.kWordSpacing,.kWritingMode]
    static let filterPrimitiveAttributes:[QySVGAttributeName] = [.kHeight,.kResult,.kWidth,.kX,.kY]
    static let transferFunctionAttributes:[QySVGAttributeName] = [.kType,.kTableValues,.kSlope,.kIntercept,.kAmplitude,.kExponent,.kOffset]
    static let animationAttributeTargetAttributes:[QySVGAttributeName] = [.kAttributeType,.kAttributeName]
    static let animationTimingAttributes:[QySVGAttributeName] = [.kBegin,.kDur,.kEnd,.kMin,.kMax,.kRestart,.kRepeatCount,.kRepeatDur,.kFill]
    static let animationValueAttributes:[QySVGAttributeName] = [.kCalcMode,.kValues,.kKeyTimes,.kKeySplines,.kFrom,.kTo,.kBy,.kAutoReverse,.kAccelerate,.kDecelerate]
    static let animationAdditionAttributes:[QySVGAttributeName] = [.kAdditive,.kAccumulate]
}
