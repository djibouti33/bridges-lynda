//: [Previous](@previous)


/*:
 # Accessibility Notifications

 **GOALS**
 * Refresh users on Notifications that are posted by UIKit and can be observed by our app
 * Introduce user's notifications we can post to assistive technology
 * Demonstrate how to post notifications to the system

 Resources
 * [Notifications](https://developer.apple.com/reference/uikit/uiaccessibility)
 ---
 */

/*:

 * callout(Demo):
   * Demo app and refresh users about accessibility notificiations posted by UIKit that we're already responding to
   * Revisit Magic Tap functionality, and demonstrate how it's not clear that the action was successful
 */

/*:

 ## BridgeDetailViewController.swift
 ### add to #accessibilityPerformMagicTap()

    let action = favoriteButton.isSelected ? "added to" : "removed from"
    if let name = bridge?.name {
      UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "\(name) \(action) favorites.")
    }

 */

/*:

 * callout(Demo):
   * Demonstrate how when we come into the detail view, VoiceOver always takes us to the back button
   * Could be a lot more convenient if we landed on the title instead
   * explain how this might not be the best idea since we shoot past the favorite button, so at this point the user has no idea that a bridge can be favorited, but this is just for demonstration purposes
 
 ## BridgeDetailViewController.swift
 ### viewDidAppear
 
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, detailWrapper.nameLabel)

 * callout(Demo):
    * Review how VO focus ring now correctly jumps right to the title
    * Demonstrate how this had no effect on Switch Control, which is sensible
    * Point out another flaw with our setup, when navigating back from an image detail, we jump back to the top
    * this was happening before we announced the layout change notification, but we'll try to optimize it so we can come back to the photo
 
 
 ## BridgeDetailViewController.swift
 ### new property
 
    var focusElement: Any?

 ### viewDidLoad
 
    focusElement = detailWrapper.nameLabel

 ### viewDidAppear
 
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, focusElement)

 ### onImageTap()
 
    focusElement = imageCollection?[currentImageIndex]

 ### onWikipediaTap
 
    focusElement = detailWrapper.wikiLabel

 * callout(Demo):
    * Demonstrate how focus ring correctly highlights the right element after navigating back

 */





//: [Next](@next)
