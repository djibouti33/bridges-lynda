//: [Previous](@previous)


/*:
 # Custom Actions

 **GOALS**
   * Introduce students to concept of magic tap
   * Demonstrate how to support magic tap
   * Demonstrate how to add custom action

 Resources
 * [UIAccessibilityAction](https://developer.apple.com/reference/uikit/uiaccessibilityaction)
 ---
 */

/*:

 * callout(Demo):
   * Demo Magic Tap and show how it's used in Camera app
   * Used to perform an important, app-specific action, usually toggling the most important state of the app
   * in our app, favoriting is very important
 
 VoiceOver defines 5 special gestures for triggering app specific actions.
 
 * Escape - a two finger z-shaped gesture that dismisses a modal dialog, or goes back one level in a navigation hierarchy
 * Magic Tap - a two finger double tap that performs the most intended action
 * Three finger scroll - a three finger swipe that scrolls content vertically or horizontally. we've been using this gesture to pan around our map view, and to reach the bottom of our detail screen to get to our image thumbnails
 * Increment - a one finger swipe up that increments a value in an element
 * Decrement - a one finger swipe down that decrements a value in an element
 
 We can use these gestures to perform tasks that are specific to our application. For example, the Music app uses the magic tap to play and pause playback. The Camera app uses the Magic tap to snap a picture.
 
 Each of these gestures has a corresponding method that you can override in your views or view controllers. UIKit will search for this method using the responder chain, starting with the element that has the VoiceOver focus.
 
 If no object implements the appropriate method, UIKit performs the default system action for that gesture.
 
 In the Bridges app, let's add support for the Magic Tap when a user is viewing a bridge's detail screen. In our implementation of the magic tap method, we'll simply toggle the favorited status for that bridge.
 
 
 */

/*:
 
 ## BridgeDetailViewController.swift
 ### new function
 
    override func accessibilityPerformMagicTap() -> Bool {
      onFavorite(favoriteButton)

      // return true to halt propagation through the responder chain
      return true
    }
 
 This is perfect. Now a VoiceOver user can easily favorite or unfavorite a bridge simply by double tapping with two fingers anywhere on the screen. In a later video, we'll learn how to post a custom notification that VoiceOver can announce in order to inform the user that their magic tap was recognized.
 
 * 

 */

/*:

 * callout(Demo):
   * Demo Magic Tap. Point out how it can be done anywhere on the screen, making it a lot easier for the user so they don't have to navigate back and forth
   * Point out how it's difficult for the user to know if the magic tap took or not
   * For that we'll post a custom notification, and we'll learn how to do that in another video
 
 
 */

/*:

 * callout(Demo):
   * Good that users can now easily favorite a bridge from the detail screen
   * But what about other actions that you might want to expose
   * for this we can create Custom actions that can be added to the Actions rotor
   * Demo on Index View, how the favoriting functionality from editactionrowitem is exposed as a VoiceOver action
   * now we'll add our own
 
 
 VoiceOver ships with a powerful feature called the Rotor, which allows users to change how VoiceOver works. Users can change the VoiceOver volume or speaking rate, move from one item to the next on the screen, and even change the way you type.
 
 To activate the rotor, you first have to make sure VoiceOver is enabled. To activate the rotor, rotate two fingers on the screen as if you're turning a physical dial. VoiceOver will say the first rotor option. Keep rotating your fingers to hear more options, and lift your fingers to choose an option. After choosing an option, flick your finger up or down on the screen to use it.
 
 It's important to note that the Rotor is context sensitive. Your rotor options will depend on which element has focus when you activate the rotor.
 
 Let's take a moment to play around with the rotor. It takes some getting used to, so feel free to pause the video and pick up again when you're ready. For this demo, I'm going to focus the first cell, and then activate the rotor by rotating two fingers on the screen. I'm going to do this until I find the Words option. With that selected, now I can flick up or down and VoiceOver will read my cells word by word. I'll activate the rotor again, choose the Characters option, and VoiceOver will now read my cell letter by letter.
 
 In the Bridges app, on the main screen, a user can pull a cell left in order to easily favorite or unfavorite a bridge. This action was creating by using a UITableViewRowAction. With this added, UIKit automatically added this action to the Rotor, within the Actions option.
 
 
 */

/*: 
 ## BridgeDetailViewController.swift
 ### #viewDidLoad
 
     configureCustomAccessibilityActions()
 
 ### implement configureCustomAccessibilityActions()
 
    func configureCustomAccessibilityActions() {
      let wikiAction = UIAccessibilityCustomAction(name: "View on Wikipedia", target: self, selector: #selector(onWikipediaCustomAction))
      self.accessibilityCustomActions = [wikiAction]
    }
 
 ### implement #onWikipediaCustomAction selector
 
    func onWikipediaCustomAction() -> Bool {
      self.onWikipediaTap(0)
      return true
    }
 
 */





//: [Next](@next)
