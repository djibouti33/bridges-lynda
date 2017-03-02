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
 
 
  In the last chapter, when we were workign with Visual Accommodations, we relied on special notifications posted by UIKit they
  we could observe and act upon in order to update our interface. We observed notifications for when a user changed the dynamic type settings, or changed their preference for reduced motion while the app was running.
 
  Along with listening for notifications, we can also post our own accessibility notifications which VoiceOver will read out loud.
 
  In a previous video, we implemented the special Magic Tap gesture, where a user could two finger double tap on a detail screen to toggle the favorite status of a bridge. Let's see that again. With the VoiceOver cursor focused on a an element in our View Controller, I'll take two fingers and double tap. Watch teh favorite button to see how it reacts to this magic tap. Awesome, it's correctly toggling it's state whenever I perform a magic tap.
 
  It'd be great if we could provide some feedback for the user to let them know the system recongized the magic tap gesture, and an accessibility notification is the perfect way to do this.
 
 */

/*:

 ## BridgeDetailViewController.swift
 ### add to #accessibilityPerformMagicTap()

    // we'll start by creating a constant that sets a sensible value depending on the favorite status of this particular bridge
    let action = favoriteButton.isSelected ? "added to" : "removed from"
 
    // and we'll simply post the notification
    if let name = bridge?.name {
      // there are different types of notifications you can post, but for us, we'll post a UIAccessibilityAnnouncementNotification,
      // and then we pass the string that we want VoiceOver to read
      UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification, "\(name) \(action) favorites.")
    }

 */

/*:

 * callout(Demo):
   * Demonstrate how when we come into the detail view, VoiceOver always takes us to the back button
   * Could be a lot more convenient if we landed on the title instead
   * explain how this might not be the best idea since we shoot past the favorite button, so at this point the user has no idea that a bridge can be favorited, but this is just for demonstration purposes
 
  Great. Now I want to show you one more thing. If we tap on the wikipedia button, when we press the done button, the VoiceOver cursor defaults back to the top left. It would be really convenient if instead, the cursor stayed on the wikipedia button so the user can continue where they left off. We can do just that by posting a UIAccessibilityLayoutChangedNotification, and passing along the element we want to be focused.
 
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

 ### viewDidAppear
 
    UIAccessibilityPostNotification(UIAccessibilityLayoutChangedNotification, focusElement)
    focusElement = nil

 ### onWikipediaTap
 
    focusElement = detailWrapper.wikiLabel

 * callout(Demo):
    * Demonstrate how focus ring correctly highlights the right element after navigating back

 */





//: [Next](@next)
