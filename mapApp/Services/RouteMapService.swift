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
    
    static let route = RouteMapService()
    
    func buildRoute(firstPoint: Point, secondPoint: Point, completion: @escaping (MKRoute?, UIAlertController?) -> ()) {
        let sourceMapItem = MKMapItem.mapItem(point: firstPoint)
        let destinationMapItem = MKMapItem.mapItem(point: secondPoint)
        let directionRequest = MKDirections.Request()
        directionRequest.source = sourceMapItem
        directionRequest.destination = destinationMapItem
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        
        directions.calculate {(response, error) -> Void in
            guard let response = response else {
                if let error = error {
                    let alert = UIAlertController(title: "Error", message: "Build a route from this geolocation is not possible", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    print("Error: \(error)")
                    completion(nil, alert)
                }
                return
            }
            let route = response.routes[0]
            completion(route, nil)
        }
    }
}
