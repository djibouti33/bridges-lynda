//
//  BridgeMapViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 2/7/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit
import MapKit

class BridgeMapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
  let locationManager = CLLocationManager()
  var bridges: [Bridge]!

  override func viewDidLoad() {
    super.viewDidLoad()
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      bridges = appDelegate.bridges
    }
    
    locationManager.requestWhenInUseAuthorization()
    mapView.showsUserLocation = true

    mapView.addAnnotations(bridges.map({ (bridge) -> BridgeAnnotation in
      return BridgeAnnotation.init(withBridge: bridge)
    }))

    configureCustomRotors()
  }

  func configureCustomRotors() {
    let favoritesRotor = UIAccessibilityCustomRotor(name: "Bridges") { predicate in
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
    }
    
    self.accessibilityCustomRotors = [favoritesRotor]
  }
}
