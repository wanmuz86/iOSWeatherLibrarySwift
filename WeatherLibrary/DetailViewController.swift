//
//  DetailViewController.swift
//  WeatherLibrary
//
//  Created by ME-Tech MacPro User 2 on 1/21/16.
//  Copyright © 2016 iTrain Asia. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher
class DetailViewController: UIViewController {
    @IBOutlet weak var tempLbl: UILabel!

    @IBOutlet weak var descLbl: UILabel!
    @IBOutlet weak var mainLbl: UILabel!
    @IBOutlet weak var pressureLbl: UILabel!
    @IBOutlet weak var humidityLbl: UILabel!
    @IBOutlet weak var logoLbl: UIImageView!
    var myObject : JSON?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let object = myObject{
            self.descLbl.text =  object["weather"][0]["description"].string
            self.mainLbl.text = object["weather"][0]["main"].string
            self.pressureLbl.text = "\(object["main"]["pressure"].numberValue)"
            self.humidityLbl.text = "\(object["main"]["humidity"].numberValue)"
            self.tempLbl.text = "\(object["main"]["temp"].numberValue.intValue - 273) C"
            self.logoLbl?.kf_setImageWithURL(NSURL(string: "http://openweathermap.org/img/w/\(object["weather"][0]["icon"].stringValue).png")!)
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
