//
//  MainViewController.swift
//  mapApp
//
//  Created by Zhassulan Aimukhambetov on 2/19/20.
//  Copyright © 2020 Zhassulan Aimukhambetov. All rights reserved.
//

import UIKit
import MapKit

class MainViewController: UIViewController {
    
    var segueIdentifire: String = ""
    var firstPoint: Point?
    var secondPoint: Point?
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var firstPointButton: UIButton!
    @IBOutlet weak var secondPointButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        mapView.overrideUserInterfaceStyle = .light
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mapView.removeOverlays(mapView.overlays)
        mapView.removeAnnotations(mapView.annotations)
        let annotations = AnnotationMapService.annotations(firstPoint: firstPoint, secondPoint: secondPoint)
        mapView.showAnnotations(annotations, animated: true)
        buildRoute()
    }
    
    private func buildRoute() {
        guard let firstPoint = firstPoint, let secondPoint = secondPoint else { return }

        RouteMapService.route.buildRoute(firstPoint: firstPoint, secondPoint: secondPoint) { (route, alert) in
            if let alert = alert {
                self.present(alert, animated: true)
                return
            }
            guard let route = route else { return }
            self.mapView.addOverlay((route.polyline), level: MKOverlayLevel.aboveRoads)
            let rect = route.polyline.boundingMapRect
            self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
    }
// MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifire = segue.identifier, let mapVC = segue.destination as? MapViewController else { return }
        segueIdentifire = identifire
        mapVC.mapViewControllerDelegate = self
    }
}
//MARK: - MapViewControllerDelegate
extension MainViewController: MapViewControllerDelegate {
    func getPoint(point: Point) {
        if segueIdentifire == "fromFirstPoint" {
            firstPoint = point
            firstPointButton.setTitle(point.title, for: .normal)
        } else {
            secondPoint = point
            secondPointButton.setTitle(point.title, for: .normal)
        }
    }
}
//MARK: - MKMapViewrDelegate
extension MainViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 4.0
        return renderer
    }
}
