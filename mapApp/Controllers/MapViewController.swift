//
//  MapViewController.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/19/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var mapViewControllerDelegate: MapViewControllerDelegate?
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.overrideUserInterfaceStyle = .light
    }
    
    @IBAction func addPointButtonTouch(_ sender: UIButton) {
        let coordinate = mapView.centerCoordinate
        mapViewControllerDelegate?.getPoint(point: Point(title: pointLabel.text, latitude: coordinate.latitude, longetude: coordinate.longitude))
        dismiss(animated: true)
    }
}
//MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        GeocoderMapService.geocoder.mapOpen(mapView: mapView) { (streetName, buildName) in
            if streetName != nil && buildName != nil {
                self.pointLabel.text = "\(streetName!) \(buildName!)"
            } else if streetName != nil {
                self.pointLabel.text = streetName!
            } else {
                self.pointLabel.text = ""
            }
        }
    }
}
