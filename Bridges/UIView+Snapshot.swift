//
//  UIView+Snapshot.swift
//  Bridges
//
//  Created by Kevin Favro on 2/6/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

// necessary to overcome bug in Xcode 8/Simulator
public extension UIView {
  public func snapshotImage() -> UIImage? {
    UIGraphicsBeginImageContextWithOptions(bounds.size, isOpaque, 0)
    drawHierarchy(in: bounds, afterScreenUpdates: false)
    let snapshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return snapshotImage
  }
  
  public func snapshotView() -> UIView? {
    if let snapshotImage = snapshotImage() {
      return UIImageView(image: snapshotImage)
    } else {
      return nil
    }
  }
}
