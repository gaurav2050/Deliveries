//
//  DeliveryItems.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 16/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import SwiftyJSON

class DeliveryItems {
    var deliveryItemsArr: [DeliveryItem] = []
    
    init() {
        deliveryItemsArr = []
    }
    
    convenience init(json: JSON) {
        self.init()
        for (_,result)  in json{
            let item = DeliveryItem(json: result)
            deliveryItemsArr.append(item)
        }
    }
}
