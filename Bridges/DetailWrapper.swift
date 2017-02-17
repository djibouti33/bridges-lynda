//
//  DetailWrapper.swift
//  Bridges
//
//  Created by Kevin Favro on 2/17/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

class DetailWrapper: UIView {
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var overviewLabel: UILabel!
  @IBOutlet weak var wikiLabel: UILabel!
  @IBOutlet weak var elevationWrapper: ElevationWrapper!

  var bridge: Bridge? {
    didSet {
      if let bridge = bridge {
        nameLabel.text = bridge.name
        overviewLabel.text = bridge.overview
        elevationWrapper.bridge = bridge
      }
    }
  }
}
