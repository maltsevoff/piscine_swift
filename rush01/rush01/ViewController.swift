//
//  ViewController.swift
//  rush01
//
//  Created by Serhii CHORNONOH on 7/5/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate {

    //var lastAnnotation : MKAnnotation?
    
    @IBOutlet weak var geoButtonOutlet: UIButton!
    @IBOutlet var searchBarMap: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var trafficButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var routeButton: UIButton!
    
    var locationManager = CLLocationManager()
    let rightButton = UIButton(type: .detailDisclosure)
    var flagDir = false
    
//    var departurePlacemark: MKPlacemark?
//    var destinationPlacemark: MKPlacemark?

    var currentPlacemark: CLPlacemark?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        searchBarMap.delegate = self
        mapView.delegate = self
        locationManagerSetup()
        mapView.showsUserLocation = true
        rightButton.addTarget(self, action: #selector(self.rightButtonClicked(_:)), for: .touchDown)
        
        
    }
    
    @IBAction func mapTypeButton(_ sender: UIButton) {
        switch mapView.mapType.rawValue {
        case 0:
            mapView.mapType = .satellite
            sender.setImage(UIImage(named: "worldwide1"), for: .normal)
            if mapView.userTrackingMode.rawValue != 1 {
                geoButtonOutlet.setImage(UIImage(named: "gps_w"), for: .normal)
            }
            if mapView.showsTraffic == false {
                trafficButton.setImage(UIImage(named: "traffic-light_w"), for: .normal)
            }
            historyButton.setImage(UIImage(named: "saved2_w"), for: .normal)
            routeButton.setImage(UIImage(named: "route_w"), for: .normal)
        case 1:
            mapView.mapType = .hybrid
            sender.setImage(UIImage(named: "worldwide2"), for: .normal)
        case 2:
            mapView.mapType = .standard
            sender.setImage(UIImage(named: "worldwide0"), for: .normal)
            if mapView.userTrackingMode.rawValue != 1 {
                geoButtonOutlet.setImage(UIImage(named: "gps0"), for: .normal)
            }
            if mapView.showsTraffic == false {
                trafficButton.setImage(UIImage(named: "traffic-light0"), for: .normal)
            }
            historyButton.setImage(UIImage(named: "saved2"), for: .normal)
            routeButton.setImage(UIImage(named: "route"), for: .normal)
        default:
            print("default case")
        }
    }
    
    // Start/stop track userLocation
    @IBAction func geoButton(_ sender: UIButton) {
        if mapView.userTrackingMode.rawValue == 0 {
            let userLocation = mapView.userLocation
            let region = MKCoordinateRegion(center: (userLocation.location?.coordinate)!, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
            mapView.userTrackingMode = MKUserTrackingMode(rawValue: 1)!
            sender.setImage(UIImage(named: "gps1"), for: .normal)
            
        } else {
            mapView.userTrackingMode = MKUserTrackingMode(rawValue: 0)!
            if mapView.mapType.rawValue == 0 {
                sender.setImage(UIImage(named: "gps0"), for: .normal)
            } else {
                sender.setImage(UIImage(named: "gps_w"), for: .normal)
            }
            
        }
    }
    
    @IBAction func trafficButton(_ sender: UIButton) {
        if mapView.mapType.rawValue != 1 {
            switch mapView.showsTraffic {
            case false:
                mapView.showsTraffic = true
                sender.setImage(UIImage(named: "traffic-light1"), for: .normal)
            case true:
                mapView.showsTraffic = false
                if mapView.mapType.rawValue == 0 {
                    sender.setImage(UIImage(named: "traffic-light0"), for: .normal)
                } else {
                    sender.setImage(UIImage(named: "traffic-light_w"), for: .normal)
                }
            }
        }
    }
    
    
    
    func locationManagerSetup() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBarMap.resignFirstResponder()
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchBar.text!) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                
                let placemark = placemarks?.first
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location!.coordinate)!
                annotation.title = self.buildAnnotationTitle(placemark: placemark)
                if annotation.title == "" {
                    annotation.title = searchBar.text!
                }
                MapData.history.append(annotation)
                self.addAnnotationFromHistory(annotation)
                
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
    }
    
    func addAnnotationFromHistory(_ annotation: MKAnnotation) {
        
        let span = MKCoordinateSpan.init(latitudeDelta: 0.015, longitudeDelta: 0.015)
        let region = MKCoordinateRegion(center: annotation.coordinate, span: span)
        
        
        self.mapView.addAnnotation(annotation)
        self.mapView.selectAnnotation(annotation, animated: true)
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if !(annotation is MKUserLocation) {
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: String(annotation.hash))
            
            rightButton.setImage(UIImage(named: "Next"), for: UIControl.State.normal)
            rightButton.tag = annotation.hash
            
            pinView.animatesDrop = true
            pinView.canShowCallout = true
            pinView.rightCalloutAccessoryView = rightButton
            
            return pinView
        } else {
            return nil
        }
    }
    
//    func mapItem(anno: MKAnnotation) -> MKMapItem {
//        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: anno.coordinate.latitude, longitude: anno.coordinate.longitude))
//        let mapItem = MKMapItem(placemark: placemark)
//        mapItem.name = anno.title!
//        return mapItem
//    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        view.removeFromSuperview()
        self.mapView.removeAnnotation(view.annotation!)
        self.mapView.removeOverlays(self.mapView!.overlays)
        self.flagDir = false
    }
    
    
    @objc func rightButtonClicked(_ sender: UIButton) {
        if MapData.setRoute {
            twoPointsRoute()
            MapData.departurePlacemark = nil
            MapData.destinationPlacemark = nil
            MapData.setRoute = false
            return 
        }
        guard let currentPlacemark = currentPlacemark else { return }
        let directionRequest = MKDirections.Request()
        let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
        
        directionRequest.source = MKMapItem.forCurrentLocation()
        directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
        directionRequest.transportType = .automobile
        
        // calculate the directions / route
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (directionsResponse, error) in
            guard let directionsResponse = directionsResponse else {
                if let error = error {
                    print("error:", error)
                    let alert = UIAlertController(title: "Error", message: "Can't find way to this location", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            let route = directionsResponse.routes[0]
            self.mapView.removeOverlays(self.mapView!.overlays)
            self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            
            var routeRect = route.polyline.boundingMapRect
            routeRect.size.width *= 1.1
            routeRect.size.height *= 1.1
            self.mapView.setRegion(MKCoordinateRegion(routeRect), animated: true)
            self.flagDir = true
        }
    }
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let location = view.annotation
        if !(location is MKUserLocation) {
            self.currentPlacemark = MKPlacemark(coordinate: location!.coordinate)
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        
        renderer.strokeColor = UIColor(red:0.07, green:0.73, blue:0.86, alpha:1.0)
        renderer.lineWidth = 4.0
        
        return renderer
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        if mapView.userTrackingMode.rawValue == 0 {
            if mapView.mapType.rawValue == 0 {
                geoButtonOutlet.setImage(UIImage(named: "gps0"), for: .normal)
            } else {
                geoButtonOutlet.setImage(UIImage(named: "gps_w"), for: .normal)
            }
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard (MapData.tmpAnnotation != nil) else { return }
        self.addAnnotationFromHistory(MapData.tmpAnnotation!)
//        if MapData.setRoute {
//            self.departureDestinationPlacemarks()
//            MapData.setRoute = false
//        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("In viwWillApper")
        if MapData.setRoute {
            departureDestinationPlacemarks()
        }
    }
    
    func buildAnnotationTitle(placemark: CLPlacemark?) -> String {
        var str = ""
        if ((placemark?.name) != nil) {
            str += "\((placemark?.name)!)"
        }
        if ((placemark?.administrativeArea) != nil) && ((placemark?.name) != nil) && placemark?.administrativeArea !=  placemark?.name {
            str += ", \((placemark?.administrativeArea)!)"
        }
        if ((placemark?.country) != nil) && ((placemark?.administrativeArea) != nil) && placemark?.country != placemark?.administrativeArea {
            str += ", \((placemark?.country)!)"
        }
        return (str)
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        if self.flagDir == true {
            guard let currentPlacemark = currentPlacemark else { return }
            let directionRequest = MKDirections.Request()
            let destinationPlacemark = MKPlacemark(placemark: currentPlacemark)
            
            directionRequest.source = MKMapItem.forCurrentLocation()
            directionRequest.destination = MKMapItem(placemark: destinationPlacemark)
            directionRequest.transportType = .automobile
            
            // calculate the directions / route
            let directions = MKDirections(request: directionRequest)
            directions.calculate { (directionsResponse, error) in
                guard let directionsResponse = directionsResponse else {
                    if let error = error {
                        print("error:", error)
                    }
                    return
                }
                let route = directionsResponse.routes[0]
                self.mapView.removeOverlays(self.mapView!.overlays)
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)
            }
        } else {
            self.mapView.removeOverlays(self.mapView!.overlays)
        }
    }
        

}

