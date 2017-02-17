//
//  ImageTransitionFromThumbToDetail.swift
//  Bridges
//
//  Created by Kevin Favro on 2/6/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

class ImageTransitionFromThumbToDetail: NSObject, UIViewControllerAnimatedTransitioning {

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    performMagicMove(using: transitionContext)
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  // MARK: - private helpers
  
  private func performMagicMove(using transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewController(forKey: .from) as! BridgeDetailViewController
    let toVC = transitionContext.viewController(forKey: .to) as! ImageDetailViewController
    let containerView = transitionContext.containerView
    
    let tappedImageView = fromVC.imageCollection.filter { (imageView) -> Bool in
      imageView.tag == fromVC.currentImageIndex
    }.first
    
    let tappedSnapshot = tappedImageView?.snapshotView()
    tappedSnapshot?.frame = containerView.convert((tappedImageView?.frame)!, from: tappedImageView?.superview)
    tappedImageView?.isHidden = true
    
    toVC.view.frame = transitionContext.finalFrame(for: toVC)
    toVC.view.alpha = 0
    toVC.imageView.isHidden = true
    
    containerView.addSubview(toVC.view)
    containerView.addSubview(tappedSnapshot!)
    
    toVC.view.layoutIfNeeded()
    
    UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
      toVC.view.alpha = 1.0
      let frame = containerView.convert(toVC.imageView.frame, from: toVC.view)
      tappedSnapshot?.frame = frame
    }) { (completed) in
      toVC.imageView.isHidden = false
      tappedImageView?.isHidden = false
      tappedSnapshot?.removeFromSuperview()
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
}
