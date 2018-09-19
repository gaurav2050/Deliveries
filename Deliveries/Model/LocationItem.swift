//
//  LocationItem.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 15/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import SwiftyJSON

class LocationItem {
    var lat: Double!
    var lng: Double!
    var address: String!
    
    init() {
        self.lat = 0
        self.lng = 0
        self.address = ""
    }
    
    convenience init(json: JSON) {
        self.init()
        if let jsonlat = json["lat"].double{
            self.lat = jsonlat
        }
        if let jsonlng = json["lng"].double{
            self.lng = jsonlng
        }
        if let jsonaddress = json["address"].string{
            self.address = jsonaddress
        }
    }
}
