//
//  BridgeDetailViewController.swift
//  Bridges
//
//  Created by Kevin Favro on 1/31/17.
//  Copyright © 2017 Lynda.com. All rights reserved.
//

import UIKit
import MapKit
import SafariServices

class BridgeDetailViewController: UIViewController, MKMapViewDelegate, UINavigationControllerDelegate {
  @IBOutlet weak var bridgeNameLabel: UILabel!
  @IBOutlet weak var bridgeOverviewLabel: UILabel!
  @IBOutlet weak var lengthElevation: ElevationLengthView!
  @IBOutlet weak var heightElevation: ElevationHeightView!
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet var imageCollection: [UIImageView]!
  @IBOutlet weak var favoriteButton: UIButton!

  var bridge: Bridge?
  var currentIndex = 0
  
  required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bridgeNameLabel.text = bridge?.name
    bridgeOverviewLabel.text = bridge?.overview
    lengthElevation.length = (bridge?.length)!
    heightElevation.height = (bridge?.height)!
    configureMapView()
    configureImageViews()
    configureFavoriteButton()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    self.navigationController?.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    animateElevations()
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    self.navigationController?.delegate = nil
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "imageDetailSegue" {
      let imageDetail = segue.destination as! ImageDetailViewController
      imageDetail.imagePath = (bridge?.imagePaths?[currentIndex])!
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
    var dict = UserDefaults.standard.dictionary(forKey: "bridge_favorites")
    
    sender.isSelected = !sender.isSelected
    
    if sender.isSelected {
      dict?[(bridge?.name)!] = true
    } else {
      _ = dict?.removeValue(forKey: (bridge?.name)!)
    }
    
    UserDefaults.standard.set(dict, forKey: "bridge_favorites")
    UserDefaults.standard.synchronize()
  }
  
  func onImageTap(sender: UITapGestureRecognizer) {
    currentIndex = (sender.view?.tag)!
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
  
  private func animateElevations() {
    UIView.animate(withDuration: 0.5, animations: {
      self.lengthElevation.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
      self.heightElevation.transform = CGAffineTransform(scaleX: 1.5,y: 1.5)
    }) { (Bool) in
      UIView.animate(withDuration: 0.5, animations: {
        self.lengthElevation.transform = CGAffineTransform.identity
        self.heightElevation.transform = CGAffineTransform.identity
      })
    }
  }
  
  private func configureMapView() {
    mapView.delegate = self
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
    var dict = UserDefaults.standard.dictionary(forKey: "bridge_favorites")
    if dict?[(bridge?.name)!] != nil {
      favoriteButton.isSelected = true
    } else {
      favoriteButton.isSelected = false
    }
  }
}
