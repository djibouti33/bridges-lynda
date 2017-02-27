//
//  BridgeMapViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 2/7/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
//

import UIKit
import MapKit

class BridgeMapViewController: UIViewController, CLLocationManagerDelegate {
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
  }
}
