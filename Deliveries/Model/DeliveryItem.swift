//
//  DeliveryItem.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 15/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeliveryItem {
    var description: String!
    var imageUrl: String!
    var id: Int!
    var location: LocationItem!
    var deliveryImage: UIImage!
    
    init() {
        self.description = ""
        self.id = 0
        self.imageUrl = ""
        self.location = LocationItem()
        self.deliveryImage = UIImage(named: "defaultImage.icns")
    }
    
    convenience init(json: JSON) {
        self.init()
        self.description = json["description"].stringValue
        self.id = json["id"].intValue
        self.imageUrl = json["imageUrl"].stringValue
        self.location = LocationItem(json: json["location"])
        let url = URL(string:self.imageUrl)
        DispatchQueue.main.async {
            if let data = try? Data(contentsOf: url!)
            {
                self.deliveryImage = UIImage(data: data)
            }
        }
    }
}
