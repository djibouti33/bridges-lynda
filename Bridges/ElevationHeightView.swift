//
//  ElevationHeightView.swift
//  Bridges
//
//  Created by Kevin Favro on 2/1/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

@IBDesignable class ElevationHeightView: UIView {
  @IBInspectable var height: Int = 0 {
    didSet {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      let num = NSNumber(integerLiteral: height)
      heightPresentation = String.localizedStringWithFormat(NSLocalizedString("%@ ft", comment: ""), formatter.string(from: num)!)
    }
  }
  private var heightPresentation: String = "0 ft"

  override func draw(_ rect: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let color = UIColor(red: 0.051, green: 0.498, blue: 0.773, alpha: 1.000)
    
    //// "H" Text Drawing
    let headingRect = CGRect(x: 0, y: 0, width: 100, height: 58)
    let headingTextContent = NSLocalizedString("H", comment: "")
    let headingStyle = NSMutableParagraphStyle()
    headingStyle.alignment = .center
    
    let headingFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 42), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: headingStyle]
    
    let headingTextHeight: CGFloat = headingTextContent.boundingRect(with: CGSize(width: headingRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: headingFontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: headingRect)
    headingTextContent.draw(in: CGRect(x: headingRect.minX, y: headingRect.minY + (headingRect.height - headingTextHeight) / 2, width: headingRect.width, height: headingTextHeight), withAttributes: headingFontAttributes)
    context!.restoreGState()
    
    //// Height Symbol Drawing
    context!.saveGState()
    context!.translateBy(x: 65.59, y: 53.02)
    context!.rotate(by: -90 * CGFloat(M_PI) / 180)
    
    let heightSymbolPath = UIBezierPath()
    heightSymbolPath.move(to: CGPoint(x: 0, y: 0))
    heightSymbolPath.addLine(to: CGPoint(x: 0, y: 11.83))
    heightSymbolPath.addLine(to: CGPoint(x: 44.52, y: 11.83))
    heightSymbolPath.addLine(to: CGPoint(x: 44.52, y: 0))
    color.setStroke()
    heightSymbolPath.lineWidth = 3
    heightSymbolPath.stroke()
    
    context!.restoreGState()
    
    //// "x ft" Drawing
    let textRect = CGRect(x: 0, y: 71.54, width: 100, height: 28.46)
    let textTextContent = NSString(string: heightPresentation)
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center

    let robotoMono = UIFont(name: "RobotoMono-Regular", size: 15)
    
    let textFontAttributes = [NSFontAttributeName: robotoMono, NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: textStyle]
    
    let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: textRect)
    textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
    context!.restoreGState()
  }
}
