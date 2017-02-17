//: [Previous](@previous)


/*:
 # Visual Accommodations: Bold Fonts and Darker Colors

 **GOALS**
 * Show students how to configure bold fonts and darker colors preferences
 * Show students how to respect a user's bold font and darker color preferences
 * Show students how to support bold font preferences with custom fonts

 Resources
 * [UIAccessibilityIsBoldTextEnabled()](https://developer.apple.com/reference/uikit/1615156-uiaccessibilityisboldtextenabled)
 * [UIAccessibilityDarkerSystemColorsEnabled()](https://developer.apple.com/reference/uikit/1615087-uiaccessibilitydarkersystemcolor)
 ---
 */

/*:
 * callout(Demo: Settings App, Bridges):
    * show where to configure Bold Preferences
    * explain how they'll require a restart
    * point out how since we're using standard label controls, they automatically pick up the change with 0 effort on our part
    * explain how we won't need to listen for a notification about this setting changing because our app will restart
    * custom fonts and drawing text with TextKit will need manual support. Point out how our custom font in our elevation views needs to be addressed. We'll fix this now.
 */

/*:
 ## ElevationHeight.swift
 ### replace robotMono declaration with:
 
     let style = UIAccessibilityIsBoldTextEnabled() ? "Bold" : "Regular"
     let robotoMono = UIFont(name: "RobotoMono-\(style)", size: 15)
 */

/*:
 ## ElevationLength.swift
 ### replace robotMono declaration with:

     let style = UIAccessibilityIsBoldTextEnabled() ? "Bold" : "Regular"
     let robotoMono = UIFont(name: "RobotoMono-\(style)", size: 15)
 */

/*:
  * callout(Demo: Settings App, Bridges):
      * show how elevation views now get updated properly with bold or regular fonts
      * Go back to settings, point out darker system colors preference. Toggle that on
      * Back in our app, show how all our text is pretty bold as it is, with the exception of the overview label
      * Let's fix that for users who are requesting darker colors
 */

/*:
 ## BridgeDetailViewController.swift
 ### viewDidLoad()
 
     add configureOverviewLabel()
 
 ### implement configureOverviewLabel()
 
    private func configureOverviewLabel() {
      let color = UIAccessibilityDarkerSystemColorsEnabled() ? UIColor.black : UIColor.lightGray
      bridgeOverviewLabel.textColor = color
    }
 
 ### back up in viewDidLoad()
 
     NotificationCenter.default.addObserver(self, selector: #selector(configureOverviewLabel), name: .UIAccessibilityDarkerSystemColorsStatusDidChange, object: nil)
 
 ### prepend private access modifier with @objc
 
     @objc private func configureOverviewLabel()
 */



//: [Next](@next)
