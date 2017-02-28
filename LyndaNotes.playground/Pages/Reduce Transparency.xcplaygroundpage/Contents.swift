//: [Previous](@previous)

/*:
 
  In our app, our cells use a transparent background to overlay text on top of the background image. This is a nice effect, but for some users, this design can be difficult to read and could even be ilegible. Fortunatley, there's a setting user's can adjust to request interfaces to reduce the use of transparency. This setting can be toggled by going to Settings > General > Accessibility > Increase Contrast, and enabling the Reduce Transparency switch.
 
 We'll do this my working through common pitfalls when working with colors and transparency.
 
  * callout(Demo: Settings App, Bridges):
    * show how our app uses transparency on tableviewcells.
    * explain how some users have difficulty seeing items overlaid on each other
    * show where to configure reduce transparency preferences
*/

/*:
 ## Main.storyboard / IndexTableViewCell.swift
 ### add to awakeFromNib()

     if UIAccessibilityIsReduceTransparencyEnabled() {
       textBackdrop.alpha = 1
     }
 */

/*:
  * callout(Demo: Bridges):
    * show how that didn't work
    * there's two ways to achieve transparency. by setting a view's transparency, and by adding alpha when declaring a color
    * if we had set the alpha on the textBackdrop view, then everything inside that view would also be affected.
    * instead, we only want the surrounding box to have reduced alpha, so we acheieved this by selecting a color and turning down it's opacity
    * if you're trying to reduce transparency in your app and it's not working, double check how you or another developer configured the transparency
    * ok, now that we know we're setting the alpha channel through a color, we'll change our code
 */

/*:
 ## Main.storyboard / IndexTableViewCell.swift
 ### add to awakeFromNib()

     textBackdrop.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)

  * note:
    * in our design, the background is white, so it's easy to set a new color to white, because we just have to set each component to 1
    * however, for any other color, we'd have to set it in IB, and then re-create that same color again here in code so the opaque version matched our designers color choices
    * we'll leave this as is for now, but at the end of this video I'll show you a better way
 */


/*:
  * callout(Demo: Bridges):
    * show how our backdrop is now fully opaque
    * explain how our app can receive a notification when the user adjusts this setting
 */

/*:
 ## BridgeIndexViewController.swift
 ### viewDidLoad()

    NotificationCenter.default.addObserver(self, selector: #selector(userDidChangeTransparencyPref), name: .UIAccessibilityReduceTransparencyStatusDidChange, object: nil)

 ### implement userDidChangeTransparencyPref()

    @objc private func userDidChangeTransparencyPref() {
      tableView.reloadData()
    }

  * note:
    * unfortunately, this won't work as we expect, because we're only adjusting transparency in awakeFromNib. Since cells are reused, we need to also configure the transparency each time they're recycled

 ## IndexTableViewCell.swift
 ### awakeFromNib()

    adjustTransparency()

 ### prepareForReuse()

    adjustTransparency()

 ### implement adjustTransparency()

    private func adjustTransparency() {
      if UIAccessibilityIsReduceTransparencyEnabled() {
        textBackdrop.backgroundColor = UIColor(colorLiteralRed: 1, green: 1, blue: 1, alpha: 1)
      }
    }

  * note:
    * ok, this will work the first time, but after that, since we're hard coding alpha 1, our cell will use that value each and every time, and our app won't respond correctly when users toggle this setting
    * instead of hardcoding these values, when the cell is first created, we'll want to capture our designer's original color and alpha settings. we'll then be able to toggle between the original alpha value or 1 if the user has enabled the reduce transparency setting. capturing the original color components will also allow us to make changes to the backgorund color in our storyboard file, and have them automatically picked up here in our code without making any other adjustments

 ### create new properties

    var originalRed:CGFloat = 0
    var originalGreen:CGFloat = 0
    var originalBlue:CGFloat = 0
    var originalAlpha:CGFloat = 0


 ### awakeFromNib(), above adjustTransparency()

    textBackdrop.backgroundColor?.getRed(&originalRed, green: &originalGreen, blue: &originalBlue, alpha: &originalAlpha)

 ### adjustTransparency()

    let newAlpha = UIAccessibilityIsReduceTransparencyEnabled() ? 1 : originalAlpha
    textBackdrop.backgroundColor = UIColor(colorLiteralRed: Float(originalRed), green: Float(originalGreen), blue: Float(originalBlue), alpha: Float(newAlpha))

 */

//: [Next](@next)
