//
//  GeocoderMapService.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/20/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import MapKit

class GeocoderMapService {
    
    static let geocoder = GeocoderMapService()
    
    func mapOpen(mapView: MKMapView, completion: @escaping (String?, String?) -> ()) {
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
                completion(streetName, buildName)
            }
        }
    }
    private func getCentreLocation(mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
    }
}
