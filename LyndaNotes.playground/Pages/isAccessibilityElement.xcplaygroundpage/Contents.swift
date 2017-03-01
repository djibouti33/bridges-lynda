//: [Previous](@previous)

/*:
 # isAccessibilityElement
 
 **GOALS**
 * Users will gain understanding in how elements do/do not participate in the accessibility system

 */

/*:
 
 * notes:
    * In the last chapter, we added support for Visual Accommodations. Now we're going to take a look at Semantic Accesibility. An app becomes accessible when its user interface elements can be described to assistive technologies like VoiceOver and Switch Control. An element can be described when it has adopted the UIAccessibility informal protocol, and it's isAccessibilityElement property has been set to true. Feel free to check out Apple's documentation for more information on this protocol. All standard UIKit controls and views adopt this protocol, so if you're using UIButtons, UILabels, and UITableviews, your app will be fairly accessible without having to do a thing. UIView's have this property set to false, so if you're app contains completely custom UIView subclasses, you'll have to do a little more work to ensure those elements are accessible. We'll learn how to do that in another video.
    * In this video, we'll fix a part of the Bridges app that is inaccessible to assitive technologies because certain elements are not marked as accessible.
 
  * callout(Bridges demo):
      * quickly walk through application. swipe through each element, pointing out how the system sees almost everything it needs to
      * on the detail screen, point out how it misses the elevation views.
      * inspect the elevation view, and talk about how this is a subclass of UIView, which is not accessible by default, and has completely custom drawing code, which is inaccessible. Later on we'll work on making this area accessible. for now let's move on
      * notice how the entire mapview can not be selected. a mapview is considered an accessibility container. the elements inside are accessible, but not the container itself. we'll be working with containers later on.
      * notice how VoiceOver completely misses the images. It doesn't evenk know their there.
      * I can't even scroll down to them
      * We'll need to make them accessible by setting their isAccessibilityElement property
      * Show them in IB
      * Then do it in code
 
 
 In our main storyboard file, we have our two elevation views. It might not look like it, but these are custom drawn elements that are created in the view's drawRect method. Anything custom drawn will be inaccessible by default. 
 
 Back in our storyboard file, we can see that our elevation views are children of the ElevationWrapper view, so why didn't VoiceOver detect that element? 
 
 If we go into ElevationWrapper, we can see it's a basic subview of UIView, which is inaccessible by default.
 
 
 
 
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
