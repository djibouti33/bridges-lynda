//: [Previous](@previous)

/*:

 # UIAccessibilityTraits

 **GOALS**
 * Introduce students to accessibility labels and hints
 * Teach students how to adjust accessibility settings in Interface Builder and in code

 */

/*:
 * callout(Bridges):
    * Review the favorite button we just worked on, and how the system included "button" and "selected"
    * Talk about how it automatically says "button" and "selected" and talk about traits
    * Show the list of traits in Interface Builder
    * Now I'll show you how to recreate the traits that iOS is doing for us automatically
 */

/*:
 ## BridgeDetailViewController.swift
 ### configureFavoriteButton()

    // top of method (outside if block)
    favoriteButton.accessibilityTraits = UIAccessibilityTraitButton

    // in if block
    favoriteButton.accessibilityTraits |= UIAccessibilityTraitSelected

    // in else block
    favoriteButton.accessibilityTraits &= ~UIAccessibilityTraitSelected
 */

/*:
 * callout(Bridges):
   * show how voiceover stays the same
   * point out wikipedia label, and how VO doesn't tell the user that this label can be tapped
   * point out how it's configured as a UILabel with a tap gesture recognizer, but VO isn't aware of that, so we need to tell it to treat it like a button
   * also go into SwitchControl mode and point out how the Switch Control focus ring completely misses the element alltogether.
   * that's because a switch control only highlights controls that can be interacted with. most likely switch control users can see fine; they just have a difficult time touching the screen. without a button trait, they'd never be able to visit the wikipedia entry.

 ## DetailWrapper.swift
 ### new method

    override func awakeFromNib() {
      wikiLabel.accessibilityTraits |= UIAccessibilityTraitButton
    }

 * callout(Bridges):
     * demo how voiceover adds the button prompt
     * demo how switch control can now successfully find it


 */

//: [Next](@next)
