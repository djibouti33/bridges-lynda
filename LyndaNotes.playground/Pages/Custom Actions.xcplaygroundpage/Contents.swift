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
 */

/*:
 
 ## BridgeDetailViewController.swift
 ### new function
 
    override func accessibilityPerformMagicTap() -> Bool {
      onFavorite(favoriteButton)

      return true
    }

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
