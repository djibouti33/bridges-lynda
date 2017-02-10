//
//  ElevationLengthView.swift
//  Bridges
//
//  Created by Kevin Favro on 2/1/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

@IBDesignable class ElevationLengthView: UIView {
  @IBInspectable var length: Int = 0 {
    didSet {
      let formatter = NumberFormatter()
      formatter.numberStyle = .decimal
      let num = NSNumber(integerLiteral: length)
      lengthPresentation = String.localizedStringWithFormat(NSLocalizedString("%@ ft", comment: ""), formatter.string(from: num)!)
    }
  }
  private var lengthPresentation: String = "0 ft"

  override func draw(_ rect: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let color2 = UIColor(red: 0.051, green: 0.498, blue: 0.773, alpha: 1.000)
    
    //// "L" Drawing
    let headingRect = CGRect(x: 0, y: 0, width: 100, height: 58)
    let headingTextContent = NSLocalizedString("L", comment: "")
    let headingStyle = NSMutableParagraphStyle()
    headingStyle.alignment = .center
    
    let headingFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 42), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: headingStyle]
    
    let headingTextHeight: CGFloat = headingTextContent.boundingRect(with: CGSize(width: headingRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: headingFontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: headingRect)
    headingTextContent.draw(in: CGRect(x: headingRect.minX, y: headingRect.minY + (headingRect.height - headingTextHeight) / 2, width: headingRect.width, height: headingTextHeight), withAttributes: headingFontAttributes)
    context!.restoreGState()
    
    //// Length Symbol Drawing
    let lengthSymbol = UIBezierPath()
    lengthSymbol.move(to: CGPoint(x: 29.59, y: 46.02))
    lengthSymbol.addLine(to: CGPoint(x: 29.59, y: 57.85))
    lengthSymbol.addLine(to: CGPoint(x: 69.59, y: 57.85))
    lengthSymbol.addLine(to: CGPoint(x: 69.59, y: 46.02))
    color2.setStroke()
    lengthSymbol.lineWidth = 3
    lengthSymbol.stroke()
    
    
    //// "x ft" Drawing
    let textRect = CGRect(x: 0, y: 71.54, width: 100, height: 28.46)
    let textTextContent = NSString(string: lengthPresentation)
    let textStyle = NSMutableParagraphStyle()
    textStyle.alignment = .center
    
    let textFontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: textStyle]
    
    let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: textRect)
    textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
    context!.restoreGState()
  }
}
