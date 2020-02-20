//
//  MKPointAnnotation.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/20/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import MapKit

extension MKPointAnnotation {
    static func annotation(point: Point) -> MKAnnotation {
        let location = CLLocation(latitude: point.latitude, longitude: point.longetude)
        let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
        let annotation = MKPointAnnotation()
        annotation.title = point.title
        if let location = placemark.location {
            annotation.coordinate = location.coordinate
        }
        return annotation
    }
}
