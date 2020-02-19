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
    private let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.overrideUserInterfaceStyle = .light
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search..."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    @IBAction func addPointButtonTouch(_ sender: UIButton) {
        mapViewControllerDelegate?.getPoint(location: getCentreLocation(mapView: mapView))
        dismiss(animated: true)
    }
    private func setupPlacemark(placeString: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(placeString) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            guard let placemarks = placemarks else { return }
            var annotations = [MKAnnotation]()
            for placemark in placemarks {
                let annotation = MKPointAnnotation()
                annotation.title = placeString
                guard let placemarkLocation = placemark.location else { return }
                annotation.coordinate = placemarkLocation.coordinate
                annotations.append(annotation)
            }
            self.mapView.showAnnotations(annotations, animated: true)
            //self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        setupPlacemark(placeString: searchText)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let centerLocation = getCentreLocation(mapView: mapView)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(centerLocation) { (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let placemarks = placemarks else { return }
            let placemark = placemarks.first
            let streetName = placemark?.thoroughfare
            let buildName = placemark?.subThoroughfare
            DispatchQueue.main.async {
                if streetName != nil && buildName != nil {
                    self.pointLabel.text = streetName! + " " + buildName!
                } else if streetName != nil {
                    self.pointLabel.text = streetName!
                } else {
                    self.pointLabel.text = ""
                }
            }
        }
    }
    
    private func getCentreLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
