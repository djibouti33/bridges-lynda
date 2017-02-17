//: [Previous](@previous)

/*:
 
 # Labels, Hints and Traits
 
 **GOALS**
  * Introduce students to accessibility labels, hints, and traits
  * Teach students how to adjust accessibility settings in Interface Builder and in code

 */

/*:
  * callout(Inspector, Bridges):
      * Demo how the inspector complains that our image is using the image name for the accessibility label
      * Demo how we could use IB to set these values, but our button has state and so we need to configure these dynamically
 */

/*:
 
  ## BridgeDetailViewController.swift
  ### configureFavoriteButton()
 
    private func configureFavoriteButton() {
      if let bridge = bridge {
        favoriteButton.isSelected = bridge.isFavorite

        if bridge.isFavorite {
            favoriteButton.accessibilityLabel = NSLocalizedString("In Favorites, Yes", comment: "")
            favoriteButton.accessibilityHint = NSLocalizedString("Double tap to remove from favorites", comment: "")
        } else {
          favoriteButton.accessibilityLabel = NSLocalizedString("In Favorites, No", comment: "")
          favoriteButton.accessibilityHint = NSLocalizedString("Double tap to add to favorites", comment: "")
        }
      } else {
        favoriteButton.isSelected = false
      }
    }
 */

/*:
  * callout(Bridges):
    * Show how inspector no longer complains
    * Walk through favoriting/unfavoriting, showing user the benefit of the labels and hints that we chose
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
    * talk about how in a later video, we'll use traits to make an element reachable to switch users
 */

//: [Next](@next)
