//
//  ViewController.swift
//  WeatherLibrary
//
//  Created by ME-Tech MacPro User 2 on 1/21/16.
//  Copyright © 2016 iTrain Asia. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
import MBProgressHUD
import SCLAlertView
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var weatherArray : [JSON] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        SCLAlertView().showInfo("Welcome", subTitle: "Welcome to my application. Hope you enjoy it.") // Info
        super.viewDidLoad()
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Alamofire.request(.GET, "http://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=44db6a862fba0b067b1930da0d769e98").responseJSON { (responseData) -> Void in
            print(responseData)
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            let swiftyJsonVar = JSON(responseData.result.value!)
            print(swiftyJsonVar)
            self.weatherArray = swiftyJsonVar["list"].array! 
            self.tableView.reloadData()
            
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherArray.count
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "detailSegue" {
           let destVC = segue.destinationViewController as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow
            destVC.myObject = self.weatherArray[selectedIndexPath!.row]
            
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        let weatherDict = weatherArray[indexPath.row] 
        cell?.textLabel?.text = weatherDict["weather"][0]["main"].stringValue
        cell?.detailTextLabel?.text = weatherDict["weather"][0]["description"].stringValue
        cell?.imageView?.kf_setImageWithURL(NSURL(string: "http://openweathermap.org/img/w/\(weatherDict["weather"][0]["icon"].stringValue).png")!)
        return cell!
    }

}

