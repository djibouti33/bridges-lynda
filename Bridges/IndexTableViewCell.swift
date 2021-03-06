//
//  IndexTableViewCell.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
//

import UIKit

class IndexTableViewCell: UITableViewCell {
  @IBOutlet weak var bridgeImage: UIImageView!
  @IBOutlet weak var bridgeNameLabel: UILabel!
  @IBOutlet weak var bridgeOverviewLabel: UILabel!
  @IBOutlet weak var textBackdrop: UIView!
  @IBOutlet weak var favoriteImage: UIImageView!

  var bridge: Bridge? {
    didSet {
      if let bridge = bridge {
        bridgeImage.image = UIImage(contentsOfFile: (bridge.imagePaths?.first)!)
        bridgeNameLabel.text = bridge.name
        bridgeOverviewLabel.text = bridge.overview
        favoriteImage.isHidden = !bridge.isFavorite
      }
    }
  }
  
  override func awakeFromNib() {
    textBackdrop.layer.borderColor = UIColor.black.cgColor
    textBackdrop.layer.borderWidth = 4
    textBackdrop.layer.cornerRadius = 15
    
    
    
    if UIAccessibilityIsReduceTransparencyEnabled() {
//      textBackdrop.alpha = 1
      textBackdrop.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)
//      textBackdrop.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)
    }
  }
  
  override func prepareForReuse() {
    bridgeNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
    bridgeOverviewLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
  }
}
