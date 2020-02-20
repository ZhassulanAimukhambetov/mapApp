//
//  MapService.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/20/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import MapKit

class RouteMapService {
    static let shared = RouteMapService()
    
    func route(firstPoint: Point, secoondPoint: Point, mapView: MKMapView) {
        let sourceAnnotation = makeAnnotation(point: firstPoint)
        let destinationAnnotation = makeAnnotation(point: secoondPoint)
        
        mapView.showAnnotations([sourceAnnotation, destinationAnnotation], animated: true)
        
        let sourceMapItem = makeMapItem(point: firstPoint)
        let destinationMapItem = makeMapItem(point: secoondPoint)
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {(response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    print("Error: \(error)")
                }
                return
            }
            let route = response.routes[0]
            mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
    private func makeAnnotation(point: Point) -> MKAnnotation {
        let location = CLLocation(latitude: point.latitude, longitude: point.longetude)
        let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
        let annotation = MKPointAnnotation()
        annotation.title = point.title
        if let location = placemark.location {
            annotation.coordinate = location.coordinate
        }
        return annotation
    }
    private func makeMapItem(point: Point) -> MKMapItem {
        let location = CLLocation(latitude: point.latitude, longitude: point.longetude)
        let placemark = MKPlacemark(coordinate: location.coordinate, addressDictionary: nil)
        return MKMapItem(placemark: placemark)
    }
}
