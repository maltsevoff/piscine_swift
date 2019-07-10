//
//  SecondViewController.swift
//  day05
//
//  Created by Oleksandr MALTSEV on 7/1/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class SecondViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        switch segmentControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .satellite
        case 2:
            mapView.mapType = .hybrid
        default:
            break
        }
    }
    
    var locManager = CLLocationManager()
    var myLocationON = false
    
    var oldIndexPos: Int?
    
    @IBAction func locationButton(_ sender: Any) {
        if !myLocationON {
            myLocationON = true
            locManager.startUpdatingLocation()
        } else {
            locManager.stopUpdatingLocation()
            myLocationON = false
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("=====================inside")
        let location = locations[0]
        let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        centerOnLocation(location: CLLocation(latitude : myLocation.latitude, longitude : myLocation.longitude))
    }
    
    func centerOnLocation(location : CLLocation) {
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func checkLocationAuthorizationStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            mapView.showsUserLocation = true
        } else {
            locManager.requestWhenInUseAuthorization()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if oldIndexPos != indexSelected {
            locManager.stopUpdatingLocation()
//        }
        myLocationON = false
        checkLocationAuthorizationStatus()
        let p = MyPoints.point[indexSelected]
        let point = PointAnnotationColor()
        point.pinColor = MyPoints.point[indexSelected].4
        let location = CLLocationCoordinate2D(latitude: p.2, longitude: p.3)
        point.coordinate = location
        point.title = p.0
        point.subtitle = p.1
        mapView.addAnnotation(point)
        mapView.setCenter(location, animated: true)
        let coordRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordRegion, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldIndexPos = indexSelected
        locManager.distanceFilter = 10
        locManager.delegate = self
        let p = MyPoints.point[0]
        let point = MKPointAnnotation()
        let location = CLLocationCoordinate2D(latitude: p.2, longitude: p.3)
        point.coordinate = location
        point.title = p.0
        point.subtitle = p.1
        mapView.addAnnotation(point)
        let coordRegion = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(coordRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        let useId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: useId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: useId)
            pinView?.canShowCallout = true
            pinView?.pinTintColor = (annotation as? PointAnnotationColor)?.pinColor
        } else {
            pinView?.annotation = annotation
            pinView?.pinTintColor = (annotation as? PointAnnotationColor)?.pinColor
        }
        return pinView
    }
}

