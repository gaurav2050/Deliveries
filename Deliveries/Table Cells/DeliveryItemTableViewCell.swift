//
//  DeliveryItemTableViewCell.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 16/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit

class DeliveryItemTableViewCell: UITableViewCell {
    
    var itemTitle: UILabel!
    var itemLocation: UILabel!
    var itemImage : UIImageView!

    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        itemImage = UIImageView(frame: CGRect(x: 5, y: 5, width: 50, height: 50))
        itemImage.contentMode = .scaleAspectFit
        self.addSubview(itemImage)
        
        let itemImageOriginX = itemImage.frame.origin.x
        let itemImageWidth = itemImage.frame.width
        
        itemTitle = UILabel(frame: CGRect(x: itemImageOriginX+itemImageWidth+5, y: 5, width: self.contentView.frame.width - (itemImageOriginX+itemImageWidth+10), height: 30))
        itemTitle.font = UIFont(name: "Open Sans", size: 10)
        self.addSubview(itemTitle)
        
        itemLocation = UILabel(frame: CGRect(x: itemTitle.frame.origin.x, y: 37, width: itemTitle.frame.width, height: 20))
        itemLocation.font.withSize(8)
        self.addSubview(itemLocation)
    }

}
