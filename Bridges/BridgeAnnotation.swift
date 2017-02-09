//
//  BridgeAnnotation.swift
//  Bridges
//
//  Created by Kevin Favro on 2/7/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit
import MapKit

class BridgeAnnotation: NSObject, MKAnnotation {
  var title: String?
  var coordinate: CLLocationCoordinate2D
  
  override var description: String {
    return "\(self.title!)"
  }
  
  init(withBridge bridge:Bridge) {
    title = bridge.name!
    coordinate = bridge.coordinate!
  }
}
