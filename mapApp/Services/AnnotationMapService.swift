//
//  AnnotationMapService.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/20/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import Foundation
import MapKit

class AnnotationMapService {

    static func annotations(firstPoint: Point?, secondPoint: Point?) -> [MKAnnotation] {
        var annotations = [MKAnnotation]()
        if let firstPoint = firstPoint {
            let firstAnnotation = MKPointAnnotation.annotation(point: firstPoint)
            annotations.append(firstAnnotation)
        }
        if let secondPoint = secondPoint {
            let secondAnnotation = MKPointAnnotation.annotation(point: secondPoint)
            annotations.append(secondAnnotation)
        }
        return annotations
    }
}
