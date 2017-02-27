//
//  ElevationWrapper.swift
//  Bridges
//
//  Created by Kevin Favro on 2/15/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
//

import UIKit

class ElevationWrapper: UIView {
  @IBOutlet weak var lengthElevation: ElevationLengthView!
  @IBOutlet weak var heightElevation: ElevationHeightView!
  
  var bridge: Bridge? {
    didSet {
      if let length = bridge?.length {
        lengthElevation.length = length
      }

      if let height = bridge?.height {
        heightElevation.height = height
      }
    }
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    UIView.animate(withDuration: 0.5, animations: {
      self.lengthElevation.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
      self.heightElevation.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
    }) { (Bool) in
      UIView.animate(withDuration: 0.5, animations: {
        self.lengthElevation.transform = CGAffineTransform.identity
        self.heightElevation.transform = CGAffineTransform.identity
      })
    }

  }
}
