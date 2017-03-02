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
 
 
 In the last video, we were introduced to the VoiceOver rotor, a powerful feature that allows users to change how VoiceOver works. We added a custom action to the built in Actions option, allowing users to easily navigate to a bridge's wikipedia entry.
 
 In this video, we're going to take a look at how we can add our own custom rotor option to the VoiceOver rotor, allowing users to navigate our mapView in a completly custom way that makes sense for our app. Let's take a look at the mapview now to see what we'll be building.
 
 Our app contains a map in order to show the locations of the different bridges we're featuring. 
 
 The bridges are located all throughout the world, so in order to find them, a user needs to pan around, looking for a pin. 
 
 Unfortunately for VoiceOver users, panning a map is pretty difficult, and there's no easy way to hop around from pin to pin. Let me show you. 
 
 I'll turn VoiceOver on. THen with three fingers, I can swipe in any direction. 
 
 It's a pretty clunky experience, and VoiceOver wants to announce every element on screen, and in a MapView, there are many, and our users might not be interested in all of them. 
 
 We want to find a way to make it easy for VoiceOver users to navigate the map, allowing them to easily move from one bridge to the next, without having to hear about all the other accessible elements on the screen.
 
 A custom VoiceOver rotor is the perfect option, and in this video I'll show you how we can implement one. It will add functionality to our map without removing or altering VoiceOver's standard behavior when workign wiht a mapview.
 
 */


/*:

 ## BridgeMapViewController.swift
 ### #viewDidLoad


     configureCustomRotors()
 
 ### impement #configureCustomRotors()
 
    // let's stub this out first.
 
    func configureCustomRotors() {
      // we'll initialize a UIAccessibilityCustomRotor by giving it a name, which VoiceOver will appear as an option in the rotor.
 
      let favoritesRotor = UIAccessibilityCustomRotor(name: "Bridges") { predicate in
 
        // for now, we'll return nil. in a little bit, we'll update this. after a user has selected the Bridges rotor option, this block will get called each time the user flicks their finger up or down. Since the chose the Bridges rotor, they're asking to navigate to the next or previous bridge. so instead of returning nil, we'll return the appropriate bridge pin
        return nil
      }

      // and now we just need to register our custom rotor with voiceover, and we do that by adding our rotor to the accessibilityCustomRotors property.
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
 
    // ok, so the first thing we need to figure out is if the user flicked their finger up or down. this will tell us if they're requesting the next or previous bridge pin.
    // this predictate object is an instance of UIAccessibilityCustomRotorSearchPredicate. from this object, we can pull the direction, and the current item that VoiceOver has focused on
    let forward = (predicate.searchDirection == .next)

    // capture which bridge pin is currently highlighted.
    // this could be nil if the user is just beginning to use the rotor
    let currentAnnotationView = predicate.currentItem.targetElement as? MKPinAnnotationView
 
    // if we got a bridge pin, we'll pull out the annotation. this is the object
    // that contains the lat/lng coordinates of our bridge.
    let currentAnnotation = (currentAnnotationView?.annotation as? BridgeAnnotation)
    // we'll use this currentAnnotation to seek through all of our mapview's annotations to figure
    // out which index we're currently on. and using the forward constant we created above, we'll
    // be able to return the next annotation the user is requesting.

    // our mapview contains all 8 bridge annotations, as well as the user's current location annotation.
    // since we're not interested in the user's current location, we'll create a constant called 
    // bridgeAnnotations with the current loction filtered out.
    // the filter method will enumerate through each item in the annotations array, and return a new
    // array of items that passed the test in this block. $0 is a shortcut and represents an individual
    // item from the annotations array. if that item is a BridgeAnnotation, the block will return true, 
    // and it will be included in the new array being stored in our bridgeAnnotations constant
    let bridgeAnnotations = self.mapView.annotations.filter { $0 is BridgeAnnotation }

    // now we're going to create a variable called currentIndex. we'll initialize it
    // to -1 if the user is going forward, or the number of bridgeAnnotations if the user is going backwards
    var currentIndex = forward ? -1 : bridgeAnnotations.count

    // ok. we have a constant that is storing all of our bridge annotations, and we have another constant
    // that may be storing the current annotation that's being highlighted by VoiceOver.
    // if bridgeAnnotations contains our currentAnnotation, we want to store that index in our currentIndex variable.
    // so we'll start out with an if/let statement, since currentAnnotation might be nil.

    if let currentAnnotation = currentAnnotation {
 
      // and then we'll loop through our bridge annotations and capture the index of the annotation if one matches
      // our current annotation. we'll use the Array's index:where: method, which takes a block and returns the index
      // as soon as the block returns true
      if let index = bridgeAnnotations.index(where: { (annotation) -> Bool in
 
        // inside the block, we're simply comparing the annotation in the loop wiht our current annotation.
        // if they match, the index of our current annotation will be returned.
        return (annotation.coordinate.latitude == currentAnnotation.coordinate.latitude) &&
        (annotation.coordinate.longitude == currentAnnotation.coordinate.longitude)
      }) {
      // and here we're just updating our current index
      currentIndex = index
      }
    }

    // now that we have our currentIndex, here's a helper to give us the next element
    // the user is requesting. this block is just going to take the integer passed in, and either increment it or decrement it
    // depending on the direction the user is flicking
    let nextIndex = {(index:Int) -> Int in forward ? index + 1 : index - 1}

    // ok, after all that, we can finally get the new index that the user is requesting
    var newIndex = nextIndex(currentIndex)

    // ok, so now we'll create a while loop, and i'll explain in a second. it'll run as long as newIndex is greater than 0
    // and less than the number of elements in bridgeAnnotations
    while newIndex >= 0 && newIndex < bridgeAnnotations.count {
      // let's pull out the annotation that the user is requesting
      let requestedAnnotation = bridgeAnnotations[newIndex]

      // we'll use the requested annotation and center our map directly over that annotation. 
      // now just a side note, it's very important that we set animated to false here. ultimately
      // we're looking for the annotation view that VoiceOver will focus on, but we don't have direct
      // access to the annotation views, since they can be recycled. the best we can do is to give our mapview
      // an annotation, and ask it for the corresponding annotationview. by setting this to false, the map
      // immediately centers over our annotation, which means the annotation is guaranteed to have an associated
      // annotationview, which is exactly what we want.
      self.mapView.setCenter(requestedAnnotation.coordinate, animated: false)
 
      // ok, so now that our map is centered over our annotation, and we know there's an annotationview to represent
      // that annotation, we can return it. just in case an annotationView can't be found, we'll wrap this
      // in an if/let statement
      if let annotationView = self.mapView.view(for: requestedAnnotation) {
 
        // ok, here's what we've been waiting for. this block expects a UIAccessibilityCustomRotorItemResult to 
        // be returned, which will just simply wrap our annotationView. we do that like this:
        return UIAccessibilityCustomRotorItemResult(targetElement: annotationView, targetRange: nil)
      }

      // if for some reason the mapview couldn't return an annotationview, we'll generate a newIndex and run through the
      // while loop again
      newIndex = nextIndex(newIndex)
    }

    // if all of this fails, we return nil, and the rotor will know there's nothing more to navigate to
    return nil
 */

/*:
 * callout(Demo):
   * Demonstrate how quickly and efficiently the rotor can move around the map
 
  Ok, so let's bring up the rotor. Again, use two fingers on the screen and rotate like a dial. keep rotating until you find our Bridges option. And with that selected, we can now flick up to go to the first bridge. flick up again to go to the second, and the third, and so on. you can flick down to step backwards through our bridges.
 
  You might notice that there are fewer pins on the map than bridges that are featured in the app. As of iOS 10.2, there's a really weird bug with MapView when VoiceOver is running, where some annotations never get plotted. If you turn VoiceOver off and rebuild, all the bridges appear on the map. I've filed a bug with Apple and hopefully they'll resolve this soon, because I think this is a really handy way to navigate our map.
 
 */

//: [Next](@next)
