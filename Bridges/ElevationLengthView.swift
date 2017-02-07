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
      lengthPresentation = "\(formatter.string(from: num)!) ft"
    }
  }
  private var lengthPresentation: String = "0 ft"

  override func draw(_ rect: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let color2 = UIColor(red: 0.051, green: 0.498, blue: 0.773, alpha: 1.000)
    
    //// Text 3 Drawing
    let text3Rect = CGRect(x: 0, y: 0, width: 100, height: 58)
    let text3TextContent = NSString(string: "L")
    let text3Style = NSMutableParagraphStyle()
    text3Style.alignment = .center
    
    let text3FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 42), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: text3Style]
    
    let text3TextHeight: CGFloat = text3TextContent.boundingRect(with: CGSize(width: text3Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: text3Rect)
    text3TextContent.draw(in: CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
    context!.restoreGState()
    
    //// Bezier 3 Drawing
    let bezier3Path = UIBezierPath()
    bezier3Path.move(to: CGPoint(x: 29.59, y: 46.02))
    bezier3Path.addLine(to: CGPoint(x: 29.59, y: 57.85))
    bezier3Path.addLine(to: CGPoint(x: 69.59, y: 57.85))
    bezier3Path.addLine(to: CGPoint(x: 69.59, y: 46.02))
    color2.setStroke()
    bezier3Path.lineWidth = 3
    bezier3Path.stroke()
    
    
    //// Text 5 Drawing
    let text5Rect = CGRect(x: 0, y: 71.54, width: 100, height: 28.46)
    let text5TextContent = NSString(string: lengthPresentation)
    let text5Style = NSMutableParagraphStyle()
    text5Style.alignment = .center
    
    let text5FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: text5Style]
    
    let text5TextHeight: CGFloat = text5TextContent.boundingRect(with: CGSize(width: text5Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: text5FontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: text5Rect)
    text5TextContent.draw(in: CGRect(x: text5Rect.minX, y: text5Rect.minY + (text5Rect.height - text5TextHeight) / 2, width: text5Rect.width, height: text5TextHeight), withAttributes: text5FontAttributes)
    context!.restoreGState()
  }
}
