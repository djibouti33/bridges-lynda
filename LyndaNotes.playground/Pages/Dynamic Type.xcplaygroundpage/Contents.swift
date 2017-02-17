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

//: ## Main.storyboard
//: Set fonts to `.title1` and `.subheadline`
 
//: ## IndexTableViewCell.swift
//:    override func prepareForReuse() {
//:        bridgeNameLabel.font = UIFont.preferredFont(forTextStyle: .title1)
//:        bridgeOverviewLabel.font = UIFont.preferredFont(forTextStyle: .subheadline)
//:    }

/*:
  * callout(Build, Run, Demo):
    * Demonstrate how Index/Detail screens pick up user's preferences
    * Comment on how cell's are truncated, but that we'll get to that later
    * Show how text will not respond to changes made while app is running
 */


//: ## BridgeIndexViewController.swift
//: ### #viewDidLoad
//:
//:    NotificationCenter.default.addObserver(self, selector: #selector(userTextSizeDidChange), name: .UIContentSizeCategoryDidChange, object: nil)

//: ### new function
//:
//:    func userTextSizeDidChange() {
//:      tableView.reloadData()
//:    }

//: ## BridgeDetailViewController.swift
//: ### #viewDidLoad
//:
//:    NotificationCenter.default.addObserver(self, selector: #selector(userTextSizeDidChange), name: .UIContentSizeCategoryDidChange, object: nil)

//: ### new function
//:
//:    func userTextSizeDidChange() {
//:      bridgeName.font = UIFont.preferredFont(forTextStyle: .title1)
//:      bridgeOverview.font = UIFont.preferredFont(forTextStyle: .body)
//:    }

/*:
 * callout(Build, Run, Demo):
   * Go back and forth between Settings, changing user's font preferences and testing results
   * Point out how lenght/height elevation views are not adapting
   * That's because those views have their font size hardcoded
   * Point out how cell's are not expanding to fit content
 */

//: ## ElevationHeightView.swift
//: ### Above declaration for robotoMono
//:
//:     let pointSize = UIFont.preferredFont(forTextStyle: .subheadline).pointSize
//:     replace 15 with pointSize when declaring robotoMono

//: ## ElevationLengthView.swift
//: ### Above declaration for robotoMono
//:
//:     let pointSize = UIFont.preferredFont(forTextStyle: .subheadline).pointSize
//:     replace 15 with pointSize when declaring robotoMono

//: ## BridgeDetailViewController.swift
//: ### userTextSizeDidChange()
//:
//:     self.lengthElevation.setNeedsDisplay()
//:     self.heightElevation.setNeedsDisplay()

/*:
 * callout(Build, Run, Demo):
    * Go back and forth between Settings, changing user's font preferences and testing results
    * Point out how cell's are not expanding to fit content
    * We'll cover that in our next video
 */


//: [Next](@next)
