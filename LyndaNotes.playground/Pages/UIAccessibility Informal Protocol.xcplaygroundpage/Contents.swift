//: [Previous](@previous)

/*:
 
 # UIAccessibility Informal Protocol

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

*/



//: [Next](@next)
