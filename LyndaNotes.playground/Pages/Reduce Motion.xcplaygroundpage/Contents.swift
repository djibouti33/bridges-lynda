//: [Previous](@previous)

/*:
 # Visual Accommodations: Reduce Motion

 **GOALS**
   * Show students how to configure motion preferences in Settings
   * Show students how to respect a user's preference for reduced motion

 Resources
 * [UIAccessibilityIsReduceMotionEnabled()](https://developer.apple.com/reference/uikit/1615133-uiaccessibilityisreducemotionena)
 ---
 */

/*:
 * callout(Bridges demo, Settings dmeo  ):
    * show how three areas of motion could be problematic for some users
      * lots of users complained about becoming dizzy or getting nauseous from iOS's use of motion and animations
      * Bridges uses motion to call attention to certain elements, for visual flair, and for a custom transition between two different view controllers
      * we'll turn those animations off so our app can provide a comfortable experience for users with sensitivities to motion
 */

/*:
 ## BridgeDetailViewController.swift
 ### #animateElevations()

     guard (UIAccessibilityIsReduceMotionEnabled() == false) else { return }
 
 ### #setMapRegion
 
    mapView.setRegion(region, animated: !UIAccessibilityIsReduceMotionEnabled())
 */

/*:
 ## ImageTransitionFromThumbToDetail.swift
 ### #animateTransition()
 
    if UIAccessibilityIsReduceMotionEnabled() {
      performCrossDisolve(using: transitionContext)
    } else {
      performMagicMove(using: transitionContext)
    }
 
 ### implement #performCrossDisolve()
 
    private func performCrossDisolve(using transitionContext: UIViewControllerContextTransitioning) {
      let toVC = transitionContext.viewController(forKey: .to) as! ImageDetailViewController
      let containerView = transitionContext.containerView

      toVC.view.frame = transitionContext.finalFrame(for: toVC)
      toVC.view.alpha = 0
      containerView.addSubview(toVC.view)

      UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
        toVC.view.alpha = 1
      }) { (completed) in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    }
 */

/*:
 ## ImageTransitionFromDetailToThumb.swift
 ### #animateTransition()

    if UIAccessibilityIsReduceMotionEnabled() {
      performCrossDisolve(using: transitionContext)
    } else {
      performMagicMove(using: transitionContext)
    }

 ### implement #performCrossDisolve()

    private func performCrossDisolve(using transitionContext: UIViewControllerContextTransitioning) {
      let toVC = transitionContext.viewController(forKey: .to) as! BridgeDetailViewController
      let containerView = transitionContext.containerView

      toVC.view.frame = transitionContext.finalFrame(for: toVC)
      toVC.view.alpha = 0
      containerView.addSubview(toVC.view)

      UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
        toVC.view.alpha = 1
      }) { (completed) in
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    }
 */

/*:
 * callout(Bridges demo):
   * show how elevation labels, map, and image transition now have motion reduced
 */

//: [Next](@next)
