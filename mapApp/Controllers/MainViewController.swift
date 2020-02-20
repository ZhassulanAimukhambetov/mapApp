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
        guard let firstPoint = firstPoint, let secondPoint = secondPoint else { return }
        mapView.removeAnnotations(mapView.annotations)
        mapView.removeOverlays(mapView.overlays)
        RouteMapService.shared.route(firstPoint: firstPoint, secoondPoint: secondPoint, mapView: mapView)
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
