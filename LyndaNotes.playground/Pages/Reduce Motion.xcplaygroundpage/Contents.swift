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
 
 iOS relies heavily on motion for navigation, visual flair, and to call attention to certain elements or actions.  For some users, too much motion or animation can cause dizziness, nausea, or motion sickness, so iOS provides a preference for users to request that apps use less motion. This preference can be found in Settings > General > Accessibility > Reduce Motion. I'll toggle this switch, and head over to the Bridges App.
 
 Let's take a look at how Bridges uses motion. When entering a detail view, our elevation views grow and then bounce back to their original size. Our mapView animates to the pin, and at the bottom, if we tap on an image thumbnail, or thumbnail grows into the larger image during the viewcontroller transition. Let's disable these animations for users who have requested reduced motion.
 
 
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
 
 7:46
 
 In order to fix this, we need to figure out what's responsible for this animation. If I look in my BridgeDetailViewContoller, and scroll to the very top, you can see this file is set as the navigation controller's delegate. Using the jump bar, we can quickly get to where we're returning an animator object to be used during a custom view controller transition. Here, I'm returning the ImageTransitionFromThumbToDetail() object, which can be over here in our project navigator.
 
 In the ImageDetailViewController file, I'm returning another custom animator object. In this case, it's the ImageTransitionFromDetailToThumb. It's in these two files where we'll want to make our adjustments.
 
 We'll start with the thumb to detail animator object. Inside an animator object, the animation happens inside the animateTransition method. Here, I'm calling out to the performMagicMove method, which is resonsible for animating and resizing the the image thumbnail to the larger version.
 
 We'll want to test for reduce motion preferences up here in the animateTransition method. Instead of an animation, we'll perform a simple cross disolve.
 
 
 
 
 ## ImageTransitionFromThumbToDetail.swift
 ### #animateTransition()
 
    if UIAccessibilityIsReduceMotionEnabled() {
      performCrossDisolve(using: transitionContext)
    } else {
      performMagicMove(using: transitionContext)
    }
 
 ### implement #performCrossDisolve()
 
    private func performCrossDisolve(using transitionContext: UIViewControllerContextTransitioning) {
      // grab a reference to the view controller we're navigating to
      let toVC = transitionContext.viewController(forKey: .to) as! ImageDetailViewController
 
      // grab a reference to the view that acts as the superview for our animation
      let containerView = transitionContext.containerView

      // make sure our toVC ends up in the correct final position
      toVC.view.frame = transitionContext.finalFrame(for: toVC)
 
      // and we'll start with alpha set to 0, meaning it will be invisible
      toVC.view.alpha = 0
 
      // and add our toVC to the containerView
      containerView.addSubview(toVC.view)

      // now we just need to perform the animation, making our toVC go from invisible to fully visible
      UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
        toVC.view.alpha = 1
      }) { (completed) in
        // we need to tell the transitionContext that our animation is complete
        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      }
    }
 */

/*:
 
 The last thing we need to do to support a user's preference for reduced motion is handle our custom view controller transitions.
 
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
