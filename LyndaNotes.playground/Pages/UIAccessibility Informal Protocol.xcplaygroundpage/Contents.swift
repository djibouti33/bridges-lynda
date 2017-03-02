//: [Previous](@previous)

/*:
 
 # UIAccessibility Informal Protocol
 
 
 Our elevation views are inaccessible by default, and in the last video, we learned how to create UIAccessibilityElements to represent them so they could be discovered by assistive technolgies.
 
 There's another approach we could have taken though, and it will require us to write a lot less code and our individual elevation views will be responsible for their own accessibility details.
 
 Since our elevation views are sublcasses of UIViews, and since the UIAccessibility protocol is an informal protocol, the only thing we need to do is to mark them as accessible elements.
 

 ## ElevationWrapper.swift
 ### delete contents of configureAccessibility()

 ## LengthElevationView.swift
 ### new method

    override func awakeFromNib() {
      self.isAccessibilityElement = true
      self.accessibilityTraits = UIAccessibilityTraitStaticText
    }

 ### length didSet{}

    self.accessibilityLabel = String.localizedStringWithFormat(NSLocalizedString("%@ long", comment: ""), lengthPresentation)

 ## HeightElevationView.swift
 ### new method

    override func awakeFromNib() {
      self.isAccessibilityElement = true
      self.accessibilityTraits = UIAccessibilityTraitStaticText
    }

 ### length didSet{}

    self.accessibilityLabel = String.localizedStringWithFormat(NSLocalizedString("%@ high", comment: ""), heightPresentation)
 */

/*:
* callout(Bridges):
  This is great. VoiceOver is reading the numbers from our elevation views, but also providing extra context so it's clear what they relate to.
 There's one more improvement we can make. Currently, VoiceOver users have to swipe twice to information about a bridge's length and height. It would be a little more convenient if these labels were combined into one, and we can do this my making the elevation view's parent the accessible element. In our case, elevation wrapper will be the accessible element, and we'll have it borrow the accessibility labels from it's children.
 
 
  * point out how we've accomplished the same thing but with a lot less code, and since we're inheriting from UIview, they're now responsible for their own accessibility settings
  * one more improvement: right now, voice over users need to swipe through two elements to get the length and height. could be nice to group that information into one element
  * we can do this by making the elevation view's parent element the accessibile container, and have it borrow the accessibility labels from it's subviews

## ElevationLengthView.swift
### remove awakeFromNib
### keep accessibilityLabel - we can still set it even though the element itself will be inaccessible

## ElevationHeightView.swift
### remove awakeFromNib

## ElevationWrapper.swift
### configureAccessibility()

    self.isAccessibilityElement = true
    self.accessibilityTraits = UIAccessibilityTraitStaticText
    self.accessibilityLabel = "\(lengthElevation.accessibilityLabel!) & \(heightElevation.accessibilityLabel!)"
 
 Since elevation wrapper is now our accessible element, Voice Over users will only have to swipe once to hear both values. It might seem small, but anything you can do to help VoiceOver users move through your interface is always appreciated.

*/



//: [Next](@next)
