//
//  ImageDetailViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 2/6/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

class ImageDetailViewController: UIViewController, UINavigationControllerDelegate {
  @IBOutlet weak var imageView: UIImageView!
  var imagePath: String = ""

  override func viewDidLoad() {
    super.viewDidLoad()
    imageView.image = UIImage.init(contentsOfFile: imagePath)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.delegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.delegate = nil
  }
  
  // MARK: - UINavigationControllerDelegate
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if (fromVC == self) && (toVC is BridgeDetailViewController) {
      return ImageTransitionFromDetailToThumb()
    }
      
    return nil
  }
}
