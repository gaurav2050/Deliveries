//
//  LocationAnnotation.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 19/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import MapKit

class LocationAnnotation: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
