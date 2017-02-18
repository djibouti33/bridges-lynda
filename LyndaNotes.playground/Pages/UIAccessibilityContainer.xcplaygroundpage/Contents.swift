//: [Previous](@previous)

/*:
  # UIAccessibilityContainer
 
  **GOALS**
  * introduce students to concept of UIAccessibilityContainer and UIAccessibilityElements
  * teach students how to convert inaccessible custom views to accessibile
 
  **RESOURCES**
  * [UIAccessibilityContainer](https://developer.apple.com/reference/uikit/uiaccessibilitycontainer)
  * [UIAccessibilityElement](https://developer.apple.com/reference/uikit/uiaccessibilityelement)
 */

/*:
  * callout(Bridges):
      * demo how elevation views are completely inaccessible
      * run through code for height/length elevation views, and demonstrate how while they inherit from uiview, all their drawing is custom, so it's completly invisible to the accessibility system
      * using uiaccessibilitycontainers, we can create accessible elements out of inaccessible parts
 */

/*:
  ## ElevationWrapper.swift
  ### layoutSubviews()
 
  * note:
    * we need to do this in layoutSubviews because awakeFromNib is too early. we need to wait until our elevation views have been properly placed and configured with their length and height information
 
      
    configureAccessibility()
 
  ## implement configureAccessibility()
 
    private func configureAccessibility() {
      // containers have to be inaccessible, since it's their children we're interested in
      self.isAccessibilityElement = false

      // since our elevation views are inaccessible, we create instances of UIAccessibilityElements
      // as proxies for our real objects. these proxies will be accessible, and hold all the information
      // needed for the iOS' accessibility system to use them correctly

      let accessibleLength = UIAccessibilityElement(accessibilityContainer: self)
      accessibleLength.accessibilityLabel = lengthElevation.lengthPresentation
      accessibleLength.accessibilityFrame = self.convert(lengthElevation.frame, to: nil)
      accessibleLength.accessibilityTraits = UIAccessibilityTraitStaticText

      let accessibleHeight = UIAccessibilityElement(accessibilityContainer: self)
      accessibleHeight.accessibilityLabel = heightElevation.heightPresentation
      accessibleHeight.accessibilityFrame = self.convert(heightElevation.frame, to: nil)
      accessibleHeight.accessibilityTraits = UIAccessibilityTraitStaticText

 
      // by setting this property, we have subscribed to the UIAccessibilityContainer informal protocol,
      // and since we also set ourselves to isAccessibilityElement=false, the system will be able to pick these
      // items up
      self.accessibilityElements = [accessibleLength, accessibleHeight]
    }
 */

/*:
 
  * callout(Bridges):
      * demo how our app can now find our elevation views
      * point out how the label isn't sufficient, since there's no indiciation or context about what the numbers mean, and that we'll fix this in a bit
      * explain how containerviews are great if you're adding items to the screen that don't inherit from UIView at all, like custom drawing performed directly in our wrapper view.
      * however, our elevationviews do inherit from UIView, and while they're inaccessibile by default, we can simply make them accessible by adopting the informal UIAccessibility protocol, and we'll do that in the next video.

 */

//: [Next](@next)
