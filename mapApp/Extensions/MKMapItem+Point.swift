//
//  MKMapItem+Point.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/20/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import MapKit

extension MKMapItem {
    static func mapItem(point: Point) -> MKMapItem {
        let location = CLLocation(latitude: point.latitude, longitude: point.longetude)
        let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
        return MKMapItem(placemark: placemark)
    }
}
