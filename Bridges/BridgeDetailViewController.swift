//
//  BridgeDetailViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 LinkedIn. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class BridgeDetailViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet var imageCollection: [UIImageView]!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var detailWrapper: DetailWrapper!

  var bridge: Bridge?
  var currentImageIndex = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()

    if let bridge = bridge {
      detailWrapper.bridge = bridge
    }

    configureMapView()
    configureImageViews()
    configureFavoriteButton()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.delegate = self
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.delegate = nil
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "imageDetailSegue" {
      let imageDetail = segue.destination as! ImageDetailViewController
      imageDetail.imagePath = (bridge?.imagePaths?[currentImageIndex])!
    }
  }
  
  // MARK: - IBAction / actions
  
  @IBAction func onWikipediaTap(_ sender: Any) {
    if let wikipediaURL = URL.init(string: (bridge?.url)!) {
      let safari = SFSafariViewController(url: wikipediaURL, entersReaderIfAvailable: true)
      self.present(safari, animated: true, completion: nil)
    }
  }

  @IBAction func onFavorite(_ sender: UIButton) {
    bridge?.isFavorite = !sender.isSelected
    configureFavoriteButton()
  }
  
  func onImageTap(sender: UITapGestureRecognizer) {
    currentImageIndex = (sender.view?.tag)!
    self.performSegue(withIdentifier: "imageDetailSegue", sender: self)
  }
  
  // MARK: - MKMapViewDelegate
  
  func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
    setMapRegion()
  }
  
  // MARK: - UINavigationControllerDelegate
  
  func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    if (fromVC == self) && (toVC is ImageDetailViewController) {
      return ImageTransitionFromThumbToDetail()
    }
    
    return nil
  }
  
  // MARK: - Private Helpers
  
  private func configureMapView() {
    mapView.delegate = self
    if let bridge = bridge {
      mapView.addAnnotation(BridgeAnnotation(withBridge: bridge))
    }
  }
  
  private func setMapRegion() {
    let region = MKCoordinateRegionMake((bridge?.coordinate)!, MKCoordinateSpanMake(0.04, 0.04))
    mapView.setRegion(region, animated: true)
  }
  
  private func configureImageViews() {
    for (index, imageView) in imageCollection.enumerated() {
      if (index < (bridge?.imagePaths?.count)!), let filePath = bridge?.imagePaths?[index] {
        imageView.tag = index
        imageView.addGestureRecognizer(createTapRecognizer())
        imageView.image = UIImage.init(contentsOfFile:filePath)
      }
    }
  }
  
  private func createTapRecognizer() -> UITapGestureRecognizer {
    let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onImageTap(sender:)))
    tapRecognizer.numberOfTapsRequired = 1
    return tapRecognizer
  }
  
  private func configureFavoriteButton() {
    if let bridge = bridge {
      favoriteButton.isSelected = bridge.isFavorite
    } else {
      favoriteButton.isSelected = false
    }
  }
}
