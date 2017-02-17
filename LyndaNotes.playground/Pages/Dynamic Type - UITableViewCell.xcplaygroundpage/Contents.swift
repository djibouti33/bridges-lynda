//: [Previous](@previous)

/*:
 # Dynamic Type - UITableViewCell

 **GOALS**
 * Introduce students to dynamic cell sizing
 * Explain to students the need for proper autolayout constraints in order for tableview to calculate dimensions

 ---
*/
/*:

 ## BridgeIndexViewController.swift
 ### #viewDidLoad

 * note: 
    * need to tell our tableView that autolayout will drive height calculations for each cell
    * delete tableViewDelegate heightForRowAtIndex
    * remmeber height used in delegate method. we'll use the same height in our estimated row height

 
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 105
 
 * callout(Build, Run, Demo):
    * Point out how UITableViewCells now have specific heights based on the content they contain

*/
 
/*:

 ## Main.storyboard

 * note:
    * Quick discussion on how there needs to be an unbroken chain of constraints and views from top to bottom
    * Explain how cell is set up:
      * text backdrop is set to proportional width and height of cell
      * background image is set to aspect fill and proportional width and height of text backdrop
      * labels are set to 0 lines so they'll automatically expand
      * unbroken constraints from top of text backdrop down to the bottom
      * this way, the content will push out the size of the text backdrop, and the cell will ensure its large enough so that the backdrop is 85%, and the imageview will take the actual dimensions of the backdrop and resize itself to fill the entire cell

*/

//: [Next](@next)
