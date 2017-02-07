//
//  ImageTransitionFromDetailToThumb.swift
//  Bridges
//
//  Created by Kevin Favro on 2/6/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

class ImageTransitionFromDetailToThumb: NSObject, UIViewControllerAnimatedTransitioning {

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    performMagicMove(using: transitionContext)
  }

  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }

  // MARK: - private helpers
  
  func performMagicMove(using transitionContext: UIViewControllerContextTransitioning) {
    let fromVC = transitionContext.viewController(forKey: .from) as! ImageDetailViewController
    let toVC = transitionContext.viewController(forKey: .to) as! BridgeDetailViewController
    let containerView = transitionContext.containerView
    
    let mainImageView = fromVC.imageView
    let mainSnapshot = mainImageView?.snapshotView()
    mainSnapshot?.frame = containerView.convert((mainImageView?.frame)!, from: mainImageView?.superview)
    mainImageView?.isHidden = true
    
    let endImageView = toVC.imageCollection.filter { (imageView) -> Bool in
      return imageView.tag == toVC.currentIndex
    }.first
    
    toVC.view.frame = transitionContext.finalFrame(for: toVC)
    toVC.view.alpha = 0
    endImageView?.isHidden = true
    
    containerView.addSubview(toVC.view)
    containerView.addSubview(mainSnapshot!)
    
    toVC.view.setNeedsLayout()
    toVC.view.layoutIfNeeded()
    
    UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
      toVC.view.alpha = 1.0
      let frame = containerView.convert((endImageView?.frame)!, from: endImageView?.superview)
      mainSnapshot?.frame = frame
    }) { (Bool) in
      endImageView?.isHidden = false
      mainImageView?.isHidden = false
      mainSnapshot?.removeFromSuperview()
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    }
  }
}
