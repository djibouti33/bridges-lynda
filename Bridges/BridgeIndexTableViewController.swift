//
//  BridgeIndexTableViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
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

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    tableView.reloadData()
  }

  // MARK: - UITableViewDatasource

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

  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true;
  }

  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    // no-op needed for editActions to work property
  }

  // MARK: - UITableViewDelegate

  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let bridge = bridges[indexPath.row]
    let title = bridge.isFavorite ? NSLocalizedString("Unfavorite", comment: "") : NSLocalizedString("Favorite", comment: "")

    let favoriteAction = UITableViewRowAction(style: .normal, title: title) { (action, indexPath) in
      bridge.isFavorite = !bridge.isFavorite
      tableView.reloadData()
    }
    favoriteAction.backgroundColor = UIColor.red
    return [favoriteAction]
  }

  override func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
    let cell = tableView.cellForRow(at: indexPath)

    // in iOS 8+, cell's clipsToBounds turns to false when entering edit mode,
    // so we need to turn it back on so our images stay cropped
    cell?.contentView.clipsToBounds = true
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
