//
//  RouteViewController.swift
//  rush01
//
//  Created by Oleksandr MALTSEV on 7/6/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RouteViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var departureTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBAction func findWayButton(_ sender: UIButton) {
        if departureTextField.text! != "" && destinationTextField.text! != "" {
            MapData.departureString = departureTextField.text!
            MapData.destinationString = destinationTextField.text!
            print(MapData.departureString, MapData.destinationString)
            MapData.setRoute = true
            navigationController?.popViewController(animated: true)
        } else {
            showAlert(errorInfo: "Fill field with valid locations.")
        }
    }
    
    func showAlert(errorInfo: String!) {
        let alert = UIAlertController(title: "Error", message: errorInfo, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ViewController {
    
    func departureDestinationPlacemarks () {
        
        let geocoder = CLGeocoder()
        let geocoder2 = CLGeocoder()
        
        geocoder.geocodeAddressString(MapData.departureString) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                let placemark = placemarks?.first
                
                MapData.departurePlacemark = MKPlacemark(placemark: placemark!)
                print(MapData.departurePlacemark)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location!.coordinate)!
                annotation.title = self.buildAnnotationTitle(placemark: placemark)
                if annotation.title == "" {
                    annotation.title = MapData.departureString
                }
                
                self.addAnnotationFromHistory(annotation)
            } else {
                print(error?.localizedDescription ?? "error")
                MapData.departurePlacemark = MKPlacemark(coordinate: self.mapView.userLocation.coordinate)
                MapData.setRoute = false
            }
        }
        geocoder2.geocodeAddressString(MapData.destinationString) { (placemarks: [CLPlacemark]?, error: Error?) in
            if error == nil {
                let placemark = placemarks?.first

                MapData.destinationPlacemark = MKPlacemark(placemark: placemark!)
                print(MapData.destinationPlacemark)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = (placemark?.location!.coordinate)!
                annotation.title = self.buildAnnotationTitle(placemark: placemark)
                if annotation.title == "" {
                    annotation.title = MapData.destinationString
                }
                
                self.addAnnotationFromHistory(annotation)
            } else {
                print(error?.localizedDescription ?? "error")
                //if MapData.departurePlacemark != nil {
                    self.performSegue(withIdentifier: "backToSearch", sender: "foo")
                //}
                MapData.setRoute = false
            }
        }
        
    }
    
    func twoPointsRoute () {
        let directionRequest = MKDirections.Request()
        
        print(MapData.departurePlacemark, MapData.destinationPlacemark)
        directionRequest.source = MKMapItem(placemark: MapData.departurePlacemark!)
        directionRequest.destination = MKMapItem(placemark: MapData.destinationPlacemark!)
        directionRequest.transportType = .automobile
        
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
}
