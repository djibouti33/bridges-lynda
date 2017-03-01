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
 
 You might have noticed that VoiceOver added the words "button" and "selected" when speaking our favorites button. Along with the accessibilityLabel and accessibilityHint, elements can have accessibilityTraits associated with them to give assistive technologies more information about an element's purpose. We'll be looking at accessibilityTraits in the next video.
 
 
 
 
  In addition to setting accessibilityLabels and accessibilityHints, we can also use accessibilityTraits to describe the behavior of  user interface elements. We were briefly introduced to traits when we worked with the favorites button, and heard VoiceOver announce the element as a button, and that it was selected.
 
  Some traits characterize an element by identifying its behavior with the behavior of a particular type of object, like a button or an image. Other traits characterize an element by describing a specific behavior the element can exhibit, such as the ability to play a sound. Let's take a look at the different traits that are available to us.
 
 In Xcode, open up our Main.storyboard file, click on the Bridge Scene to open our detail scene, and select one of the images on the bottom. Over on the right, in the identity inspector, go to the Accessibiity section, and you can see all 16 traits available to us. As you can see, multiple traits can be combined.
 
 Standard UIKit controls, such as a button or a text field, provide default content in the traits attribute. If you use only standard UIKit controls in your application and don't modify their behavior in any way, you won't have to make any adjustements to the traits attribute.
 
 Our favorites button is a standard UIButton, which is why VoiceOver automatically announced it as a button and selected. As a simple exercise, let's go into the code and recreate these traits that UIKit had set by default.

 
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
   * that's because a switch control only highlights controls that can be interacted with. most likely switch control users can see fine; they just have a difficult time touching the screen. without a button trait, they'd never go through a lot of troublein order to visit the wikipedia entry.

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
