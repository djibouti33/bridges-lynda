//: [Previous](@previous)

/*:
 
 # Labels, Hints
 
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
      * now let's take a look at the images thumbnails. if you remember, VoiceOver was simply reading off their file names.
      * ideally we'd have information about each image to use as a label. unfortunately we don't, but we can still provide helpful information
 
  ## BridgeDetailViewController.swift
  ### configureImageViews()
 
    imageView.accessibilityLabel = "Photo \(index + 1) of \(imageCollection.count)"

  * callout(Bridges):
      * show how images now have helpful accessibility labels
      * switching gears, go to indexviewcontroller and point out how our labels are read backwards. the title should be read first, then the overview.
 
 ## IndexTableViewCell.swift
 ### bottom of bridge#didSet{}
 
    if let name = bridge.name, let overview = bridge.overview {
      self.accessibilityLabel = "\(name), \(overview)"
    }


 */

//: [Next](@next)
