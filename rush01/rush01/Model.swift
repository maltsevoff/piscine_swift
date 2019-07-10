//
//  Model.swift
//  rush01
//
//  Created by Serhii CHORNONOH on 7/6/19.
//  Copyright © 2019 Serhii CHORNONOH. All rights reserved.
//

import UIKit
import MapKit

struct MapData {
    static var history : [MKAnnotation] = []
    static var tmpAnnotation : MKAnnotation?
    static var departureString: String = ""
    static var destinationString: String = ""
    static var departurePlacemark: MKPlacemark?
    static var destinationPlacemark: MKPlacemark?
    static var setRoute: Bool = false
}
