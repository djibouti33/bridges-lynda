//
//  IndexTableViewCell.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
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
      bridgeImage.image = UIImage(contentsOfFile: (bridge?.imagePaths?.first)!)
      bridgeNameLabel.text = bridge?.name
      bridgeOverviewLabel.text = bridge?.overview
      favoriteImage.isHidden = !(bridge?.isFavorite)!
    }
  }
  
  override func awakeFromNib() {
    textBackdrop.layer.borderColor = UIColor.black.cgColor
    textBackdrop.layer.borderWidth = 4
    textBackdrop.layer.cornerRadius = 15
  }
}
