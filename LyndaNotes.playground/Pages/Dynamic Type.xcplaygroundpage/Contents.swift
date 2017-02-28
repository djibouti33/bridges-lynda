//: [Previous](@previous)

/*:
 # Dynamic Type

 **GOALS**
 * Introduce students to the Settings screen where font size preferences are set
 * Introduce students to setting preferredFontSize via Interface Builder
 * Introduce students to setting preferredFontSize in code
 * Introduce students to observing and responding to size preference changes
 
---
*/

/*:
 
 As we've seen in previous videos, iOS ships with powerful assistive technolgoies like VoiceOver and Switch Control that enable users with severe disabilities to use their phone. From the developer's perspective, supporting these technologies requires us to think about Semantic Accessibility. Supporting Semantic Accessibility will be the focus of the next chapter. In this chapter, we're going to focus on Visual Accommodations, settings that users with low vision or certain sensitivities can configure in the Settings app to improve their experience while using the apps they love.
 
 An extremely important setting we can support as developers is Dynamic Text, a feature that allows a user to adjust their preferred reading size. Adjustments can be made in the Settings app by going to Settings > General > Accessibility > Larger Text. I'll go ahead and enable Larger Accessibility Sizes, and adjust the slider to the maximum size so we can easily see the effects in our app.
 
 If we head over to the Bridges app, we'll see that we're not supporting this preference. In this video, we'll be learning how to support Dynamic Text in our apps, and how to respond dynamically to changes made by the user.
 
 
 
 */


/*: ## Main.storyboard

 If we look at our labels, you can see we're using fixed font sizes. In order to support dynamic text, we'll want to use a font style instead. 
 
 We choose a font style, and at runtime, iOS will decide the optimal size based off of various factors, like device, screen size, and orientation.
 
 

Set fonts to `.title1` and `.subheadline`
*/

/*:
  * callout(Build, Run, Demo):
    * Demonstrate how Index/Detail screens pick up user's preferences
    * Comment on how cell's are truncated, but that we'll get to that later
    * Show how text will not respond to changes made while app is running
    * Fortunately, we can observe a notification that UIKit posts each time a user adjusts their reading size preference
 */

/*:
 We'll start in IndexTableViewCell.swift. Because tableViewCell's can be reused, we'll want to make sure these values are set in code so that each time it gets reused, we can be certain it's picking up the user's most recent size preference. Since UIFonts are immutable, we'll need to assign a brand new font to our labels.
 
 The best place to do this is in prepareForReuse, which gets called each time a cell is about to be reused.
 */

//: ## IndexTableViewCell.swift
//:    override func prepareForReuse() {
//:        // we'll ask iOS for the preferred font for the same text styles we set in our storyboard file
//:        bridgeNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
//:        bridgeOverviewLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
//:    }

//: Now that our cell is configured to pick up a user's reading size preferences each time it gets reused, we'll head over to BridgeIndexViewController to listen for the UIKit notification


//: ## BridgeIndexViewController.swift
//: ### #viewDidLoad
//:
//:    NotificationCenter.default.addObserver(self, selector: #selector(userTextSizeDidChange), name: .UIContentSizeCategoryDidChange, object: nil)

//: ### new method
/*:

    deinit {
      NotificationCenter.default.removeObserver(self)
    }
 */

//: ### new function
//:
//:    @objc private func userTextSizeDidChange() {
//:      tableView.reloadData()
//:    }

//: ## BridgeDetailViewController.swift
//: ### #viewDidLoad
//:
//:    NotificationCenter.default.addObserver(self, selector: #selector(userTextSizeDidChange), name: .UIContentSizeCategoryDidChange, object: nil)

//: ### new function
//:
/*:    
    // MARK: - Private Helpers

    @objc private func userTextSizeDidChange() {
      detailWrapper.setNeedsLayout()
      detailWrapper.layoutIfNeeded()
    }
 
    ## DetailWrapper.swift
    ### new method
 
    override func layoutSubviews() {
      nameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
      overviewLabel.font = UIFont.preferredFont(forTextStyle: .body)
      wikiLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
    }
 */

/*:
 * callout(Build, Run, Demo):
   * Go back and forth between Settings, changing user's font preferences and testing results
   * Point out how lenght/height elevation views are not adapting
   * That's because those views have their font size hardcoded
 */


//: [Next](@next)
