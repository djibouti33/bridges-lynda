//
//  Bridge.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import Foundation
import MapKit

class Bridge: CustomStringConvertible {
  var name: String?
  var overview: String?
  var yearBuilt: String?
  var imagePaths: [String]?
  var url: String?
  var coordinate: CLLocationCoordinate2D?
  var length: Int?
  var width: Int?
  var height: Int?
  var clearance: Int?

  var isFavorite: Bool {
    get {
      if let dict = UserDefaults.standard.dictionary(forKey: "bridge_favorites"), let name = self.name {
        return dict[name] != nil
      }

      return false
    }

    set {
      if var dict = UserDefaults.standard.dictionary(forKey: "bridge_favorites"), let name = name {
        if newValue == true {
          dict[name] = true
        } else {
          dict.removeValue(forKey: name)
        }

        UserDefaults.standard.set(dict, forKey: "bridge_favorites")
        UserDefaults.standard.synchronize()
      }
    }
  }

  var description: String {
    return "\(self.name!)"
  }
  
  convenience init(withDictionary dictionary:[String:Any]) {
    self.init()
    name = NSLocalizedString(dictionary["name"] as! String, comment: "")
    overview = NSLocalizedString(dictionary["overview"] as! String, comment: "")
    yearBuilt = dictionary["year"] as? String
    imagePaths = dictionary["imagePaths"] as? Array
    url = dictionary["url"] as? String
    length = dictionary["length"] as? Int
    width = dictionary["width"] as? Int
    height = dictionary["height"] as? Int
    clearance = dictionary["clearance_below"] as? Int
    
    if let lat = dictionary["latitude"] as? CLLocationDegrees, let lng = dictionary["longitude"] as? CLLocationDegrees {
      coordinate = CLLocationCoordinate2DMake(lat, lng)
    }
    
    let folderId = dictionary["folderId"] as! String
    let directoryPath = "bridge_data/\(folderId)"
    imagePaths = Bundle.main.paths(forResourcesOfType: "jpg", inDirectory: directoryPath)
  }
}
