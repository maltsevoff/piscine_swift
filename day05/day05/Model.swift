//
//  Model.swift
//  day05
//
//  Created by Oleksandr MALTSEV on 7/1/19.
//  Copyright © 2019 Oleksandr MALTSEV. All rights reserved.
//

import Foundation
import MapKit

struct Place {
    static var places: [String] = [
        "UnitFactory",
        "Verkhovna Rada",
        "Olympysky"
    ]
}

struct MyPoints {
    static var point : [(String, String, Double, Double, UIColor)] = [
        ("UnitFactory", "You may study here", 50.468819, 30.462095, UIColor.red),
        ("Verkhovna Rada", "About politics", 50.447330, 30.536884, UIColor.blue),
        ("Olympysky", "Sport stadium", 50.433050, 30.521964, UIColor.green)
    ]
}

var indexSelected: Int = 0

class PointAnnotationColor: MKPointAnnotation {
    var pinColor = UIColor()
}
