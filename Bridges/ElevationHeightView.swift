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
      heightPresentation = "\(formatter.string(from: num)!) ft"
    }
  }
  private var heightPresentation: String = "0 ft"

  override func draw(_ rect: CGRect) {
    //// General Declarations
    let context = UIGraphicsGetCurrentContext()
    
    //// Color Declarations
    let color2 = UIColor(red: 0.051, green: 0.498, blue: 0.773, alpha: 1.000)
    
    //// Text 3 Drawing
    let text3Rect = CGRect(x: 0, y: 0, width: 100, height: 58)
    let text3TextContent = NSString(string: "H")
    let text3Style = NSMutableParagraphStyle()
    text3Style.alignment = .center
    
    let text3FontAttributes = [NSFontAttributeName: UIFont.systemFont(ofSize: 42), NSForegroundColorAttributeName: UIColor.black, NSParagraphStyleAttributeName: text3Style]
    
    let text3TextHeight: CGFloat = text3TextContent.boundingRect(with: CGSize(width: text3Rect.width, height: CGFloat.infinity), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: text3FontAttributes, context: nil).size.height
    context!.saveGState()
    context!.clip(to: text3Rect)
    text3TextContent.draw(in: CGRect(x: text3Rect.minX, y: text3Rect.minY + (text3Rect.height - text3TextHeight) / 2, width: text3Rect.width, height: text3TextHeight), withAttributes: text3FontAttributes)
    context!.restoreGState()
    
    //// Bezier 3 Drawing
    context!.saveGState()
    context!.translateBy(x: 65.59, y: 53.02)
    context!.rotate(by: -90 * CGFloat(M_PI) / 180)
    
    let bezier3Path = UIBezierPath()
    bezier3Path.move(to: CGPoint(x: 0, y: 0))
    bezier3Path.addLine(to: CGPoint(x: 0, y: 11.83))
    bezier3Path.addLine(to: CGPoint(x: 44.52, y: 11.83))
    bezier3Path.addLine(to: CGPoint(x: 44.52, y: 0))
    color2.setStroke()
    bezier3Path.lineWidth = 3
    bezier3Path.stroke()
    
    context!.restoreGState()
    
    //// Text 5 Drawing
    let text5Rect = CGRect(x: 0, y: 71.54, width: 100, height: 28.46)
    let text5TextContent = NSString(string: heightPresentation)
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
