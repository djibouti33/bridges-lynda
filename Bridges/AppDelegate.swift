//
//  AppDelegate.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  var bridges: [Bridge]?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

    // read from our bridges.plist and load bridges to be used throughout application
    if let path = Bundle.main.path(forResource: "bridge_data/Bridges", ofType: "plist"),
      let bridgeData = NSArray(contentsOfFile:path) as? [Dictionary<String, AnyObject>] {

      var bridges = [Bridge]()

      for dict: Dictionary in bridgeData {
        let bridge = Bridge(withDictionary: dict)
        bridges.append(bridge)
      }
      self.bridges = bridges;
    } else {
      self.bridges = [];
    }

    let dict = [String:Any]()
    if (UserDefaults.standard.dictionary(forKey: "bridge_favorites") == nil) {
      UserDefaults.standard.set(dict, forKey: "bridge_favorites")
      UserDefaults.standard.synchronize()
    }

    return true
  }
}
