//: [Previous](@previous)

/*:
 # VoiceOver Rotor

 **GOALS**
 * Introduce students to Rotor (Apple.com Safar?)
 * Demonstrate how difficult it is to browse a map
 * Demonstrate how to configure and use a custom rotor

 Resources
 * [About VoiceOver Rotor](https://support.apple.com/en-us/HT204783)
 * [WWDC 2016 ](https://developer.apple.com/videos/play/wwdc2016/202/) (begins at 24:17)
 ---
 */

/*:

 * callout(Demo, Rotor in Safari on Apple.com):
   * Show how rotor can navigate by elements of similar kind
   * Go into Bridges and demonstrate how difficult it is to navigate our map and see all our pins
   * In our app tapping on a pin just shows it's name, but you could see how easy it would be to take the
     user to the detail screen or let them zoom right in on the pin, so making it easy to navigate by pins
     is important. 
   * We'll go ahead and create a Rotor for all our Bridge pins. Could also create a rotor for just our Favorite Bridges
 */


/*:

 ## BridgeMapViewController.swift
 ### #viewDidLoad


     configureCustomRotors()
 
 ### impement #configureCustomRotors()
 
    func configureCustomRotors() {
      let favoritesRotor = UIAccessibilityCustomRotor(name: "Bridges") { predicate in
        return nil
      }

      self.accessibilityCustomRotors = [favoritesRotor]
    }
 */

/*:

 * callout(Demo):
    * show how "Bridges" rotor option is now available when zoomed in on map
    * point out how rotor menus are context sensitive, so options will be different depending on which item you currently have activated
 */

/*:

 ## BridgeMapViewController.swift
 ### finish #configureCustomRotors()

 replace `return nil` with:
 
    // capture direction
    let forward = (predicate.searchDirection == .next)

    // which element is currently highlighted
    let currentAnnotationView = predicate.currentItem.targetElement as? MKPinAnnotationView
    let currentAnnotation = (currentAnnotationView?.annotation as? BridgeAnnotation)

    // easy reference to all possible annotations
    let allAnnotations = self.mapView.annotations.filter { $0 is BridgeAnnotation }

    // we'll start our index either 1 less or 1 more, so we enter at either 0 or last element
    var currentIndex = forward ? -1 : allAnnotations.count

    // set our index to currentAnnotation's index if we can find it in allAnnotations
    if let currentAnnotation = currentAnnotation {
      if let index = allAnnotations.index(where: { (annotation) -> Bool in
        return (annotation.coordinate.latitude == currentAnnotation.coordinate.latitude) &&
        (annotation.coordinate.longitude == currentAnnotation.coordinate.longitude)
      }) {
      currentIndex = index
      }
    }

    // now that we have our currentIndex, here's a helper to give us the next element
    // the user is requesting
    let nextIndex = {(index:Int) -> Int in forward ? index + 1 : index - 1}

    currentIndex = nextIndex(currentIndex)

    while currentIndex >= 0 && currentIndex < allAnnotations.count {
      let requestedAnnotation = allAnnotations[currentIndex]

      self.mapView.setCenter(requestedAnnotation.coordinate, animated: false)
      if let annotationView = self.mapView.view(for: requestedAnnotation) {
        return UIAccessibilityCustomRotorItemResult(targetElement: annotationView, targetRange: nil)
      }

      currentIndex = nextIndex(currentIndex)
    }

    return nil
 */

/*:
 * callout(Demo):
   * Demonstrate how quickly and efficiently the rotor can move around the map
 */

//: [Next](@next)
