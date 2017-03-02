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
 
  Earlier, I showed you how VoiceOver was skipping over our elevation views. Let's see that again. Our elevation views are basic subclasses of UIView, which are inaccessible by default. Additionally, all custom drawing occurs in the view's drawRect method, so VoiceOver won't be able to understand these elements as they are.
 
  Fortunately, we can create UIAccessibilityElements as proxies for our elevation views. These proxies will be accessible, and hold all of the information needed for assistive technologies to use them correctly. UIAccessibility elements have many of the same properties that we've been working with from the UIAccessibility protocol.
 
  UIAccessibilityElements need to be added to an accessibilityContainer, and it's easy to set that up.
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
      // needed for the iOS' accessibility system to use them correctly. UIAccessibilityElements have
      // many of the same properties that we've been working with from the UIAccessibility protocol.

      // i'll start by initializing a new accessibility element
      let accessibleLength = UIAccessibilityElement(accessibilityContainer: self)
 
      // i'll then give our element a label. we'll use the length elevation's lengthPresentation property
      accessibleLength.accessibilityLabel = lengthElevation.lengthPresentation
 
      // VoiceOver needs to know how to find this element, so we'll just use the frame of our length elevation view
      // and convert it to screen coordinates
      accessibleLength.accessibilityFrame = self.convert(lengthElevation.frame, to: nil)
 
      // now that VoiceOver can find our accessibility element, we just need to give it a trait so voice over understands what
      // it's working with. we'll choose the static text trait
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
 
 PU1: redo elevation accessibility, point out the inspector bug, tell them i'll quit it and rebuild, demo again, continue on
 
 Now that we've created accessibility elements to represent our elevation views, let's see if VoiceOver can find them. It found them correctly, but you'll notice that the focus ring isn't surrounding our elevation views correctly. It turns out there's a bug with the Accessibility Inspector, and if you had it open and had adjusted the dynamic type settings, iOS miscalculates the accessibility frame when converting to screen coordinates. We'll need to quit the Accessibility Inspector and rebuild our app.
 
 
 PU2: correct method name misspelling
 PU3: correct heighelevation for rest of video
 
 there's one more thing we'll want to do. let's change the scale of our tranform to 1.5. This will help VoiceOver draw a more accurate focus ring around our accessibile elements.
 
  * callout(Bridges):
      * demo how our app can now find our elevation views
      * point out how the label isn't sufficient, since there's no indiciation or context about what the numbers mean, and that we'll fix this in a bit
      * explain how containerviews are great if you're adding items to the screen that don't inherit from UIView at all, like custom drawing performed directly in our wrapper view.
      * however, our elevationviews do inherit from UIView, and while they're inaccessibile by default, we can simply make them accessible by adopting the informal UIAccessibility protocol, and we'll do that in the next video.
 
  If you listen closely, the label that's being read for our elevation views contains no context, so it's not clear to a VoiceOver user what these numbers mean. We'll fix that in a bit. 
 
  If you're adding items to the screen that don't inherit from UIView, or are using views where all of the drawing is performed in the drawRect method, you'll need to use accessibility containers and add accessibility elements to them so assisitve technologies can work with them.
 
  In the next video, I'll show you another approach to making our elevation views accessible, without having to create UIAccessibilityElements.

 */

//: [Next](@next)
