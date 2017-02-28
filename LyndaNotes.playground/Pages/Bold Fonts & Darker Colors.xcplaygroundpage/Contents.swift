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
 
 
  The last two Visual Accommodations we'll be adding support for will be Bold Text and Darker System Colors. Users with visual impairments might find it easier to read text that is darker and bolder, and they can set these preference in Settings > General > Accessibility.  Enabling Bold Text requires a restart, and when we come back, you can see the change immediately. Labels are bolder and more pronounced. If we go back to the Accessibility Settings and into Increase Contrast, we can enable darker colors.
 
 Let's go into the Bridges app and see what we have.
 
 When we enabled the bold text preference, the phone was forced to restart, which means our app was also restarted. Because of this, and because we're using standard system font styles, our lables are automatically converted to a bold weight. There's one exception though, and if we navigate to a detail screen, the elevation views don't quite look right. If you remember from a previous video, that's because we're using a custom font, and we'll need to handle this special use case.
 
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
 
 4:44
 
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
