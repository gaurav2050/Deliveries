//
//  DeliveryLocationDetailViewController.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 18/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit
import MapKit

class DeliveryLocationDetailViewController: UIViewController {
    
    var mapView: MKMapView!
    let heightOfStatusBar = UIApplication.shared.statusBarFrame.height
    var containerView: UIView!
    var deliveryDetailView: UIView!
    var deliveryTitle: UILabel!
    var deliveryImage: UIImageView!
    var deliveryLocation: UILabel!
    var deliveryDetail: DeliveryItem!
    let regionRadius: CLLocationDistance = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.lightGray
        
        self.title = "Delivery Detail"
        
        containerView = UIView(frame: CGRect(x: 10, y: (navigationController?.navigationBar.frame.height)! + heightOfStatusBar + 20, width: self.view.frame.width-20, height: self.view.frame.height - ((navigationController?.navigationBar.frame.height)! + heightOfStatusBar + 40)))
        containerView.backgroundColor = UIColor.white
        view.addSubview(containerView)
        
        let initialLocation = CLLocation(latitude: deliveryDetail.location.lat, longitude: deliveryDetail.location.lng)
        mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: containerView.frame.width, height: containerView.frame.height * 0.8))
        containerView.addSubview(mapView)
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        
        let artwork = LocationAnnotation(title: deliveryDetail.description,
                              locationName: deliveryDetail.location.address,
                              coordinate: CLLocationCoordinate2D(latitude: deliveryDetail.location.lat, longitude: deliveryDetail.location.lng))
        mapView.addAnnotation(artwork)
        
        deliveryDetailView = UIView(frame: CGRect(x: 0, y: mapView.frame.height, width: containerView.frame.width, height: containerView.frame.height * 0.2))
        containerView.addSubview(deliveryDetailView)
        
        deliveryImage = UIImageView(frame: CGRect(x: 5, y: 5, width: deliveryDetailView.frame.width*0.2, height: deliveryDetailView.frame.height * 0.7))
        let url = URL(string:deliveryDetail.imageUrl)
        if let data = try? Data(contentsOf: url!)
        {
            deliveryImage.image = UIImage(data: data)
        }
        deliveryDetailView.addSubview(deliveryImage)
        
        deliveryTitle = UILabel(frame: CGRect(x: deliveryImage.frame.origin.x + deliveryImage.frame.width + 2, y: 5, width: deliveryDetailView.frame.width*0.75, height: deliveryDetailView.frame.height * 0.45))
        deliveryTitle.text = deliveryDetail.description
        deliveryDetailView.addSubview(deliveryTitle)
        deliveryTitle.sizeToFit()
        
        deliveryLocation = UILabel(frame: CGRect(x: deliveryImage.frame.origin.x + deliveryImage.frame.width + 2, y: deliveryTitle.bounds.origin.y + deliveryTitle.bounds.height + 2, width: deliveryDetailView.frame.width*0.75, height: deliveryDetailView.frame.height * 0.45))
        deliveryLocation.text = deliveryDetail.location.address
        deliveryDetailView.addSubview(deliveryLocation)
        deliveryDetailView.sizeToFit()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DeliveryLocationDetailViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? LocationAnnotation else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}

