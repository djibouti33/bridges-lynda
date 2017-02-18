//: [Previous](@previous)

/*:
 # isAccessibilityElement
 
 **GOALS**
 * Users will gain understanding in how elements do/do not participate in the accessibility system

 */

/*:
 
 * notes:
    * Making our apps accessible for users means using objects that are represented by accessibility elements. Elements are marked as accessible and are visible to assistive technologies when their isAccessibilityElement property is set to true. All standard UIKit controls have this property set, which means many of our applications are fairly accessible without us having to do a thing. If you're using UIButton, UILabel, or UITableView for example, the system will handle most of the heavy lifting, and you just need to provide application specific details when the default values are incomplete.
    * UIView's have this property set to false, so if you're app contains completely custom UIView subclasses, you'll have to do a little more work to ensure those elements are available to assitive technologies. We'll look at how to do that in a later video.
    * In this video, we'll fix a part of the Bridges app that is inaccessible to our users because certain elements haven't been made available to the accessibility system.
 
  * callout(Bridges demo):
      * quickly walk through application. swipe through each element, pointing out how the system sees almost everything it needs to
      * on the detail screen, point out how it misses the elevation views.
      * inspect the elevation view, and talk about how this is a subclass of UIView, which is not accessible by default, and has completely custom drawing code, which is inaccessible. Later on we'll work on making this area accessible. for now let's move on
      * notice how the entire mapview can not be selected. mapview is considered an accessibility container. the elements inside are accessible, but not the container itself. you probably don't want to mess with the default settings, or assume VoiceOver users don't need to navigate a map.
      * notice how VoiceOver completely misses the images. It doesn't evenk know their there.
      * I can't even scroll down to them
      * We'll need to make them accessible by setting their flag
      * Show them in IB
      * Then do it in code
 
 
  ## BridgeDetailViewController.swift
  ### configureImageViews()
 
    imageView.isAccessibilityElement = true

  * note:
    * you might be tempted to keep this set to false, assuming a blind person wouldn't need to know about an image on screen.
    * in general we don't want to make assumptions on behalf of our users. our goal is to make sure the entire app is accessible to all different types of people with differing abilities. VoiceOver users aren't necessarily completly blind, and even still, there's a specific VoiceOver setting that allows a user to choose whether or not they want to navigate images. It's better to leave these types of choices up to the user. Additionally,  VoiceOver isn't the only assistive technology we're supporting here. Switch Control users can generally see just fine, but without these images exposed to the system, they'll never be able to interact with them.
 

  * callout(Bridges):
      * with the isAccessibilityElement flag set to yes for our images, if we build and run again, we'll see that VoiceOver and Switch Control are now aware of their existence and correctly navigate to these accessibility items.
      * VoiceOver is reading the path of our image, which isn't helpful, but for now, at least it knows their there.
 */

//: [Next](@next)
