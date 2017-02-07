//
//  BridgeIndexTableViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit

class BridgeIndexTableViewController: UITableViewController {
  var bridges: [Bridge]!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      bridges = appDelegate.bridges
    }
  }

  // MARK: - Table view data source

  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bridges.count
  }

  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "indexCell", for: indexPath) as! IndexTableViewCell
    cell.bridge = bridges[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 105
  }
  
  // MARK: - Navigation

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let bridgeDetail = segue.destination as? BridgeDetailViewController,
       let index = tableView.indexPathForSelectedRow?.row
    {
        bridgeDetail.bridge = bridges[index]
    }
  }
}
