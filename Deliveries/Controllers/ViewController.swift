//
//  ViewController.swift
//  Deliveries
//
//  Created by Gaurav Rangnani on 14/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView: UITableView!
    let heightOfStatusBar = UIApplication.shared.statusBarFrame.height
    var deliveryItems = DeliveryItems()
    var offLimit: Int = 0
    var endOfResults: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        self.title = "Delivery List"
        
        tableView = UITableView(frame: CGRect(x: 10, y: (navigationController?.navigationBar.frame.height)! + heightOfStatusBar + 20, width: self.view.frame.width - 20, height: self.view.frame.height - ((navigationController?.navigationBar.frame.height)! + heightOfStatusBar + 20)), style: UITableViewStyle.plain)
        tableView.estimatedRowHeight = 120
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DeliveryItemTableViewCell.self, forCellReuseIdentifier: "deliveryCell")
        view.addSubview(tableView)
        
        getDeliveryList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.deliveryItems.deliveryItemsArr.count
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (tableView.numberOfRows(inSection: 0) - 1) && !endOfResults {
            offLimit = tableView.numberOfRows(inSection: 0)
            getDeliveryList()
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "deliveryCell", for: indexPath) as! DeliveryItemTableViewCell
        cell.itemTitle.text = deliveryItems.deliveryItemsArr[indexPath.row].description
        cell.itemLocation.text = ": at " + deliveryItems.deliveryItemsArr[indexPath.row].location.address
        cell.itemImage.image = deliveryItems.deliveryItemsArr[indexPath.row].deliveryImage
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DeliveryLocationDetailViewController()
        vc.deliveryDetail = deliveryItems.deliveryItemsArr[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func getDeliveryList(){
        SVProgressHUD.show()
        Alamofire.request("https://mock-api-mobile.dev.lalamove.com/deliveries?offset=\(offLimit)&limit=20").responseJSON { (response) in
            print(response)
            SVProgressHUD.dismiss()
            if response.result.isSuccess{
                if let temp = response.data{
                    if let json = try? JSON(data: temp) {
                        
                        let results = DeliveryItems(json: json)
                        if results.deliveryItemsArr.count > 0{
                            self.deliveryItems.deliveryItemsArr.append(contentsOf: results.deliveryItemsArr)
                            self.tableView.reloadData()
                        }else{
                            self.endOfResults = true
                            let alert = UIAlertController(title: "Message", message: "This is end of delivery list, all results loaded successfully!", preferredStyle: UIAlertControllerStyle.alert)
                            let alertAction = UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil)
                            alert.addAction(alertAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                }
            }else{
                let alert = UIAlertController(title: "Failure", message: "Unable to get data from server!!", preferredStyle: UIAlertControllerStyle.alert)
                let alertAction = UIAlertAction(title: "Try Again", style: UIAlertActionStyle.default, handler: { (alert) in
                    self.getDeliveryList()
                })
                alert.addAction(alertAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}

