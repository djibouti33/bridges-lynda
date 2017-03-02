//: [Previous](@previous)

/*:
 
 # Labels, Hints
 
 **GOALS**
  * Introduce students to accessibility labels, hints, and traits
  * Teach students how to adjust accessibility settings in Interface Builder and in code

 */

/*:
 
 In the last video, we learned how an element declares itself accessible so assitive technologies can access them.  When VoiceOver focuses on an accessible element, it reads a description out loud. If VoiceOver lands on a label, it defaults to reading that label to a user. As we saw when touring the Accessibility Inspector, if it lands on an image, it defaults to reading the image's file name.
 
 The UIAccessibility protocol has two properties that we can set to override these defaults and provide more meaningful, helpful, or contextual descriptions of our accessible elements.
 
 
 In this video, we'll learn about accessibilityLabel and accessibilityHint, and how to use them in order to provide a better experience for VoiceOver users.
 
  * callout(Inspector, Bridges):
      * Demo how the inspector complains that our image is using the image name for the accessibility label
      * Demo how we could use IB to set these values, but our button has state and so we need to configure these dynamically
 */

/*:
 
 We can help the user out a little more by providing an accessibilityLabel.
 
 There are a few guidelines we should consider when creating an accessibilityLabel:
 
 GUIDELINES WHEN CREATING A LABEL
 
 * Briefly describes the element - Ideally, the label consists of a single word, such as add, play, delete
 * Does not include the type of control or view - accessibilityTraits are for type information, and should never be repeated in a label
 * Begins with a capitalized word - this helps VoiceOver read the label with the proper inflection
 * Does not end with a period - the label is not a sentence and should not end with a period
 * Localized - For many other reasons, your strings should be localized. But VoiceOver speaks in whichever language the user specifies on their phone, so a localized string can help with VoiceOver's pronunciation.
 
 
 If the results of a user's action on a control or view are not clearly implied by its label, we can create an accessibilityHint. There are also some guidelines we should follow.
 
 GUIDELINES WHEN CREATING A HINT
 
 * Very briefly describes the results - brevity decreases the amount of time users must spend listening before they can use the element
 * Begins with a verb and omits the subject - You'll want to use the third person singluar declarative form of a verb, such as "Plays" and not the imperative, such as "Play" to avoid sounding like you're issuing a command
 * Begins with a capitalized word and ends with a period - the hint is a phrase, not a sentence, but ending with a period will help VoiceOver speak with the appropriate inflection
 * Does not include the name of the action or gesture - A hint does not tell users how to perform the action, it tells them what will happen when they perform the action
 * Does not include the name of the control or view - The user gets this information from the label, so don't repeat it in the hint
 * Localized - as with accessibilityLabels, the hint should be provided in the user's localized language
 
 With this in mind, let's add a hint to our favorites button
 
  ## BridgeDetailViewController.swift
  ### configureFavoriteButton()
 
    private func configureFavoriteButton() {
      if let bridge = bridge {
        favoriteButton.isSelected = bridge.isFavorite

        if bridge.isFavorite {
            favoriteButton.accessibilityLabel = NSLocalizedString("In Favorites, Yes", comment: "")
 
            // in most cases, the accessibilityLabel is all you'll need. sometimes though, a little more information
            // is helpful, so you can use the accessibilityHint to provide a brief description of the result of performing
            // an action.
            favoriteButton.accessibilityHint = NSLocalizedString("Removes this bridge from your favorites.", comment: "")
        } else {
          favoriteButton.accessibilityLabel = NSLocalizedString("In Favorites, No", comment: "")
          favoriteButton.accessibilityHint = NSLocalizedString("Adds this bridge to your favorites.", comment: "")
        }
      } else {
        favoriteButton.isSelected = false
      }
    }
 
 great, after the label is read, VoiceOver pauses, and then reads the hint. the accessibility hint give a VoiceOver user a little more information about what will happen if they activate the favorites button.
 */

/*:
  * callout(Bridges):
    * Show how inspector no longer complains
    * Walk through favoriting/unfavoriting, showing user the benefit of the labels and hints that we chose
    * Talk about how it automatically says "button" and "selected" and talk about traits
 
 
 Now let's listen to how VoiceOver reads our thumbnails. VoiceOver is defaulting to the image's file name, and this is causing a really frustrating experience that will be confusing to the user. It's easy to add a sensible description though, so let's do that.
 
 It might be practical to instead describe
 
 For some apps, it might be practical to use the accessbilityLabel to describe what's happening in the image. In this case, I'm choosing to use the accessibilityLabel to inform the user about how many images exist
 
 Telling the user how many images exist will help them understand our interface and gives them a sense of how many elements in this section they'll need to navigate through.
 
 ## BridgeDetailViewController.swift
 ### configureImageViews

    imageView.accessibilityLabel = "Photo, \(index + 1) of \(imageCollection.count)"
 
 [ DEMO ]
 
 Now let's go back to the main screen, and see how VoiceOver is reading our tableViewCells.
 
 [ DEMO ]
 
 We didn't set any accessibilityLabels on our cells. VoiceOver is correctly using our name and overview labels by default, but unfortunately the order in which they are spoken is inconsistent. On the top cell, the overview of the bridge is spoken first, and then the name, and on the second cell, the name of the bridge is spoken before the overview.
 
 Let's fix this by setting a clear accessibilityLabel so VoiceOver doesn't have to guess.
 
 
 ## IndexTableViewCell.swift
 ### awakeFromNib
 
    self.accessibilityLabel = "\(bridgeName.text), \(bridgeOverviewLabel.text)"
    // now these elements will be consistently spoken in order
 
*/

//: [Next](@next)
