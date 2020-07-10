//
//  QySVGDictionary.swift
//  SVG2Code
//
//  Created by Le Quang on 6/25/20.
//  Copyright © 2020 Le Quang. All rights reserved.
//

import Foundation
let qySVGStoreAttributeTypeEntry:[String:QySVGAttributeValue.Type] = [
    QySVGAttributeName.kAccentHeight.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAccumulate.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAdditive.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAlignmentBaseline.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAllowReorder.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAlphabetic.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAmplitude.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kArabicForm.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAscent.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAttributeName.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAttributeType.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAutoReverse.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kAzimuth.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBaseFrequency.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBaselineShift.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBaseProfile.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBbox.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBegin.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBias.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kBy.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kCalcMode.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kCapHeight.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kClass.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kClip.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kClipPathUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kClipPath.rawValue:QySVGClipPathValue.self,
    QySVGAttributeName.kClipRule.rawValue:QySVGFillRuleValue.self,
    QySVGAttributeName.kColor.rawValue:QySVGColorValue.self,
    QySVGAttributeName.kColorInterpolation.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kColorInterpolationFilters.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kColorProfile.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kColorRendering.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kContentScriptType.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kContentStyleType.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kCursor.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kCx.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kCy.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kD.rawValue:QySVGPathValue.self,
    QySVGAttributeName.kDecelerate.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDescent.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDiffuseConstant.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDirection.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDisplay.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDivisor.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDominantBaseline.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDur.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDx.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kDy.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kEdgeMode.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kElevation.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kEnableBackground.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kEnd.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kExponent.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kExternalResourcesRequired.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFill.rawValue:QySVGPaintValue.self,
    QySVGAttributeName.kFillOpacity.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kFillRule.rawValue:QySVGFillRuleValue.self,
    QySVGAttributeName.kFilter.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFilterRes.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFilterUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFloodColor.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFloodOpacity.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFontFamily.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFontSize.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kFontSizeAdjust.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFontStretch.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFontStyle.rawValue:QySVGFontStyleValue.self,
    QySVGAttributeName.kFontVariant.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFontWeight.rawValue:QySVGFontWeightValue.self,
    QySVGAttributeName.kFormat.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFrom.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFr.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kFx.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kFy.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kG1.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kG2.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kGlyphName.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kGlyphOrientationHorizontal.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kGlyphOrientationVertical.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kGlyphRef.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kGradientTransform.rawValue:QySVGTransformValue.self,
    QySVGAttributeName.kGradientUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kHanging.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kHeight.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kHref.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kHreflang.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kHorizAdvX.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kHorizOriginX.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kId.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kIdeographic.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kImageRendering.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kIn.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kIn2.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kIntercept.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kK.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kK1.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kK2.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kK3.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kK4.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kKernelMatrix.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kKernelUnitLength.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kKerning.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kKeyPoints.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kKeySplines.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kKeyTimes.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kLang.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kLengthAdjust.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kLetterSpacing.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kLightingColor.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kLimitingConeAngle.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kLocal.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMarkerEnd.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMarkerMid.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMarkerStart.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMarkerHeight.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMarkerUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMarkerWidth.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMask.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMaskContentUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMaskUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMathematical.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMax.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMedia.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMethod.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMin.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kMode.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kName.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kNumOctaves.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOffset.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOpacity.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kOperator.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOrder.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOrient.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOrientation.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOrigin.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOverflow.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOverlinePosition.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kOverlineThickness.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPanose1.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPaintOrder.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPath.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPathLength.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPatternContentUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPatternTransform.rawValue:QySVGTransformValue.self,
    QySVGAttributeName.kPatternUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPing.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPointerEvents.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPoints.rawValue:QySVGLengthListValue.self,
    QySVGAttributeName.kPointsAtX.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPointsAtY.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPointsAtZ.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPreserveAlpha.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPreserveAspectRatio.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kPrimitiveUnits.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kR.rawValue:QySVGLengthListValue.self,
    QySVGAttributeName.kRadius.rawValue:QySVGLengthListValue.self,
    QySVGAttributeName.kReferrerPolicy.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRefX.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRefY.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRel.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRenderingIntent.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRepeatCount.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRepeatDur.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRequiredExtensions.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRequiredFeatures.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRestart.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kResult.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRotate.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kRx.rawValue:QySVGLengthListValue.self,
    QySVGAttributeName.kRy.rawValue:QySVGLengthListValue.self,
    QySVGAttributeName.kScale.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSeed.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kShapeRendering.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSlope.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSpacing.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSpecularConstant.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSpecularExponent.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSpeed.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSpreadMethod.rawValue:QySVGSpreadMethodValue.self,
    QySVGAttributeName.kStartOffset.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStdDeviation.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStemh.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStemv.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStitchTiles.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStopColor.rawValue:QySVGColorValue.self,
    QySVGAttributeName.kStopOpacity.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kStrikethroughPosition.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStrikethroughThickness.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kString.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kStroke.rawValue:QySVGPaintValue.self,
    QySVGAttributeName.kStrokeDasharray.rawValue:QySVGLengthListValue.self,
    QySVGAttributeName.kStrokeDashoffset.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kStrokeLinecap.rawValue:QySVGLineCapValue.self,
    QySVGAttributeName.kStrokeLinejoin.rawValue:QySVGLineJoinValue.self,
    QySVGAttributeName.kStrokeMiterlimit.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kStrokeOpacity.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kStrokeWidth.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kStyle.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSurfaceScale.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kSystemLanguage.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTabindex.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTableValues.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTarget.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTargetX.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTargetY.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTextAnchor.rawValue:QySVGTextAnchorValue.self,
    QySVGAttributeName.kTextDecoration.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTextRendering.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTextLength.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTo.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kTransform.rawValue:QySVGTransformValue.self,
    QySVGAttributeName.kTransformOrigin.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kType.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kU1.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kU2.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kUnderlinePosition.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kUnderlineThickness.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kUnicode.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kUnicodeBidi.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kUnicodeRange.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kUnitsPerEm.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVAlphabetic.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVHanging.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVIdeographic.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVMathematical.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kValues.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVectorEffect.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVersion.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVertAdvY.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVertOriginX.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVertOriginY.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kViewBox.rawValue:QySVGViewBoxValue.self,
    QySVGAttributeName.kViewTarget.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kVisibility.rawValue:QySVGVisibilityValue.self,
    QySVGAttributeName.kWidth.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kWidths.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kWordSpacing.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kWritingMode.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kX.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kXHeight.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kX1.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kX2.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kXChannelSelector.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkActuate.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkArcrole.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkHref.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkRole.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkShow.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkTitle.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXlinkType.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXmlBase.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXmlLang.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kXmlSpace.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kY.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kY1.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kY2.rawValue:QySVGLengthValue.self,
    QySVGAttributeName.kYChannelSelector.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kZ.rawValue:QySVGStringValue.self,
    QySVGAttributeName.kZoomAndPan.rawValue:QySVGStringValue.self
]

let qySVGStoreAttributeEntry:[String:((String,QySVGValuePriority)->QySVGAttributeValue)] = [
    QySVGAttributeName.kAccentHeight.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAccumulate.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAdditive.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAlignmentBaseline.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAllowReorder.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAlphabetic.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAmplitude.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kArabicForm.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAscent.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAttributeName.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAttributeType.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAutoReverse.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kAzimuth.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBaseFrequency.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBaselineShift.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBaseProfile.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBbox.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBegin.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBias.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kBy.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kCalcMode.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kCapHeight.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kClass.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kClip.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kClipPathUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kClipPath.rawValue:QySVGClipPathValue.make,
    QySVGAttributeName.kClipRule.rawValue:QySVGFillRuleValue.make,
    QySVGAttributeName.kColor.rawValue:QySVGColorValue.make,
    QySVGAttributeName.kColorInterpolation.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kColorInterpolationFilters.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kColorProfile.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kColorRendering.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kContentScriptType.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kContentStyleType.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kCursor.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kCx.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kCy.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kD.rawValue:QySVGPathValue.make,
    QySVGAttributeName.kDecelerate.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDescent.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDiffuseConstant.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDirection.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDisplay.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDivisor.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDominantBaseline.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDur.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDx.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kDy.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kEdgeMode.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kElevation.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kEnableBackground.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kEnd.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kExponent.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kExternalResourcesRequired.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFill.rawValue:QySVGPaintValue.make,
    QySVGAttributeName.kFillOpacity.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kFillRule.rawValue:QySVGFillRuleValue.make,
    QySVGAttributeName.kFilter.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFilterRes.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFilterUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFloodColor.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFloodOpacity.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFontFamily.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFontSize.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kFontSizeAdjust.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFontStretch.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFontStyle.rawValue:QySVGFontStyleValue.make,
    QySVGAttributeName.kFontVariant.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFontWeight.rawValue:QySVGFontWeightValue.make,
    QySVGAttributeName.kFormat.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFrom.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFr.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kFx.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kFy.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kG1.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kG2.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kGlyphName.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kGlyphOrientationHorizontal.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kGlyphOrientationVertical.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kGlyphRef.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kGradientTransform.rawValue:QySVGTransformValue.make,
    QySVGAttributeName.kGradientUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kHanging.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kHeight.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kHref.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kHreflang.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kHorizAdvX.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kHorizOriginX.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kId.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kIdeographic.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kImageRendering.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kIn.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kIn2.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kIntercept.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kK.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kK1.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kK2.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kK3.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kK4.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kKernelMatrix.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kKernelUnitLength.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kKerning.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kKeyPoints.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kKeySplines.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kKeyTimes.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kLang.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kLengthAdjust.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kLetterSpacing.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kLightingColor.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kLimitingConeAngle.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kLocal.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMarkerEnd.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMarkerMid.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMarkerStart.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMarkerHeight.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMarkerUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMarkerWidth.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMask.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMaskContentUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMaskUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMathematical.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMax.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMedia.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMethod.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMin.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kMode.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kName.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kNumOctaves.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOffset.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOpacity.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kOperator.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOrder.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOrient.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOrientation.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOrigin.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOverflow.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOverlinePosition.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kOverlineThickness.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPanose1.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPaintOrder.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPath.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPathLength.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPatternContentUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPatternTransform.rawValue:QySVGTransformValue.make,
    QySVGAttributeName.kPatternUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPing.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPointerEvents.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPoints.rawValue:QySVGLengthListValue.make,
    QySVGAttributeName.kPointsAtX.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPointsAtY.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPointsAtZ.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPreserveAlpha.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPreserveAspectRatio.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kPrimitiveUnits.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kR.rawValue:QySVGLengthListValue.make,
    QySVGAttributeName.kRadius.rawValue:QySVGLengthListValue.make,
    QySVGAttributeName.kReferrerPolicy.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRefX.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRefY.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRel.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRenderingIntent.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRepeatCount.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRepeatDur.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRequiredExtensions.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRequiredFeatures.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRestart.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kResult.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRotate.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kRx.rawValue:QySVGLengthListValue.make,
    QySVGAttributeName.kRy.rawValue:QySVGLengthListValue.make,
    QySVGAttributeName.kScale.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSeed.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kShapeRendering.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSlope.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSpacing.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSpecularConstant.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSpecularExponent.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSpeed.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSpreadMethod.rawValue:QySVGSpreadMethodValue.make,
    QySVGAttributeName.kStartOffset.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStdDeviation.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStemh.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStemv.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStitchTiles.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStopColor.rawValue:QySVGColorValue.make,
    QySVGAttributeName.kStopOpacity.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kStrikethroughPosition.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStrikethroughThickness.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kString.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kStroke.rawValue:QySVGPaintValue.make,
    QySVGAttributeName.kStrokeDasharray.rawValue:QySVGLengthListValue.make,
    QySVGAttributeName.kStrokeDashoffset.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kStrokeLinecap.rawValue:QySVGLineCapValue.make,
    QySVGAttributeName.kStrokeLinejoin.rawValue:QySVGLineJoinValue.make,
    QySVGAttributeName.kStrokeMiterlimit.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kStrokeOpacity.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kStrokeWidth.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kStyle.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSurfaceScale.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kSystemLanguage.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTabindex.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTableValues.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTarget.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTargetX.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTargetY.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTextAnchor.rawValue:QySVGTextAnchorValue.make,
    QySVGAttributeName.kTextDecoration.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTextRendering.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTextLength.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTo.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kTransform.rawValue:QySVGTransformValue.make,
    QySVGAttributeName.kTransformOrigin.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kType.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kU1.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kU2.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kUnderlinePosition.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kUnderlineThickness.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kUnicode.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kUnicodeBidi.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kUnicodeRange.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kUnitsPerEm.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVAlphabetic.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVHanging.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVIdeographic.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVMathematical.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kValues.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVectorEffect.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVersion.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVertAdvY.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVertOriginX.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVertOriginY.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kViewBox.rawValue:QySVGViewBoxValue.make,
    QySVGAttributeName.kViewTarget.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kVisibility.rawValue:QySVGVisibilityValue.make,
    QySVGAttributeName.kWidth.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kWidths.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kWordSpacing.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kWritingMode.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kX.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kXHeight.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kX1.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kX2.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kXChannelSelector.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkActuate.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkArcrole.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkHref.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkRole.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkShow.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkTitle.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXlinkType.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXmlBase.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXmlLang.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kXmlSpace.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kY.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kY1.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kY2.rawValue:QySVGLengthValue.make,
    QySVGAttributeName.kYChannelSelector.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kZ.rawValue:QySVGStringValue.make,
    QySVGAttributeName.kZoomAndPan.rawValue:QySVGStringValue.make
]

