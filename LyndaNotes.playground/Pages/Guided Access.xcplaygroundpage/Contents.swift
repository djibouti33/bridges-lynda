//: [Previous](@previous)

/*: 
 # Guided Access
 
 **GOALS**
 * Introduce purpose behind Guided Access
 * Demonstrate how to enable Guided Access in Settings
 * Demonstrate how to configure, then activate Guided Access
 * Demonstrate circling content to disable
 * Demonstrate how to use the Guided Access API to limit specific features and functionality while in Guided Access mode
 * Demonstrate how to add custom, App specific options to the Guided Access Options menu
 
 Resources
 * [UIGuidedAccessRestrictionDelegate](https://developer.apple.com/reference/uikit/uiguidedaccessrestrictiondelegate)
 * [UIKit Functions](https://developer.apple.com/reference/uikit/uikit_functions#//apple_ref/swift/func/c:@F@UIAccessibilityIsGuidedAccessEnabled)
 * [Guided Access Notification](https://developer.apple.com/reference/uikit/uiaccessibility?preferredLanguage=occ)
 * [WWDC 2013 ](https://developer.apple.com/videos/play/wwdc2013/202/) (begins at 39:16)
 * [How to enable and configure Guided Access](https://support.apple.com/en-us/HT202612)
 ---
 */

/*:
 * callout(Settings.app, Guided Access demo):
   * Go into Settings > General > Guided Access > Enable (we've enabled, but not activated yet)
   * No need to add Guided Access to Accessibility Shortcuts. Triple click and show how it's already been added to menu
   * Don't configure passcode. We'll do this when we enable it for the first time
   * Demonstrate guided access: Open Briges, Triple Click, enter options screen. Explain options
   * Explain disabling content by circling it. Explain how it's crude and rudimentary, and doesn't actaully work.
   * Introduce using Guided Access API to programmatically exclude features and functionality
 */


/*:

 ## BridgeDetailViewController.swift
 ### #viewDidLoad
 
 * note:
    * we'll repurpose `configureFavoriteButton` and add some more logic
    * because swift selectors need to be exposed to the obj-c runtime, we must prepend our private access modifier with @objc


     NotificationCenter.default.addObserver(self, selector: #selector(configureFavoriteButton), name: .UIAccessibilityGuidedAccessStatusDidChange, object: nil)

     prepend @objc to private func configureFavoriteButton

 */

/*:
 ### #configureFavoriteButton
 
 ````
 favoriteButton.isHidden = UIAccessibilityIsGuidedAccessEnabled()
 favoriteButton.isEnabled = !UIAccessibilityIsGuidedAccessEnabled()
 ````
*/

/*:

 * callout(Build, Run, Demo):
    * Switch between turning Guided Access off and on, watching the favorite button disappear
    * However, maybe we want the owner of the phone (teacher, parent) to decide which features and functionality should be disabled on a per use basis.
    * For that, we can create custom restrictions by adopting the UIGuidedAccessRestrictionDelegate protocol in our application delegate

 */

/*:
 
 ## AppDelgate.swift
     
 ### add UIGuidedAccessRestrictionDelegate protocol
 */

/*:
 ### new struct (top of AppDelegate)

    struct GuidedAccessRestrictions {
      static let FavoriteRestriction = "com.lynda.bridges.favoriteRestriction"
    }
 */

/*:
 ### adopt protocol
 
    // MARK: - UIGuidedAccessRestrictionDelegate
 
    var guidedAccessRestrictionIdentifiers: [String]? = [
      GuidedAccessRestrictions.FavoriteRestriction
    ]

    func textForGuidedAccessRestriction(withIdentifier restrictionIdentifier: String) -> String? {
      if restrictionIdentifier == GuidedAccessRestrictions.FavoriteRestriction {
        return "Favorites"
      }

      return nil
    }

    func detailTextForGuidedAccessRestriction(withIdentifier restrictionIdentifier: String) -> String? {
      if restrictionIdentifier == GuidedAccessRestrictions.FavoriteRestriction {
        return "Favorite/unfavorite bridges"
      }

      return nil
    }

    func guidedAccessRestriction(withIdentifier restrictionIdentifier: String, didChange newRestrictionState: UIGuidedAccessRestrictionState) {
      NotificationCenter.default.post(name: Notification.Name(GuidedAccessRestrictions.DidChangeNotification), object: nil)
    }
 */

/*:
 
 * callout(Build, Run, Demo):
   * show how restriction appears in options menu
   * explain that we now need to respond to when a user wants this feature disabled

 */

/*:
 ## AppDelegate.swift
 
 ### new member to GuidedAccessRestrictions struct
 
     static let DidChangeNotification = "com.lynda.bridges.didChangeNotification"
 
 ### last protocol method to adopt
 
    func guidedAccessRestriction(withIdentifier restrictionIdentifier: String, didChange newRestrictionState: UIGuidedAccessRestrictionState) {
      NotificationCenter.default.post(name: Notification.Name(GuidedAccessRestrictions.DidChangeNotification), object: nil)
    }
 */

/*:
 ## BridgeIndexViewController.swift
 
 ### #viewDidLoad
    
    Change Notification name to NSNotification.Name(GuidedAccessRestrictions.DidChangeNotification)
 
 ### update #configureFavoriteButton
 
    let favoriteRestricted = UIGuidedAccessRestrictionStateForIdentifier(GuidedAccessRestrictions.FavoriteRestriction)
 
    if favoriteRestricted == .allow {
      favoriteButton.isHidden = false
      favoriteButton.isEnabled = true
    } else if favoriteRestricted == .deny {
      favoriteButton.isHidden = true
      favoriteButton.isEnabled = false
    }
 */




//: [Next](@next)
