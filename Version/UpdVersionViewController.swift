//
//  UpdVersionViewController.swift
//  Version
//
//  Created by April on 12/4/15.
//  Copyright © 2015 HapApp. All rights reserved.
//

import UIKit
import Alamofire

class UpdVersionViewController: UIViewController {
    
    var info :[String : String]?
    @IBOutlet weak var Vname: UILabel!
    @IBOutlet weak var Vvalue: UITextField!
    @IBAction func updVersion(sender: UIButton) {
        let a = ["xname":"\(info!["xname"]!)","version":"\(Vvalue.text!)"]
        //        print(a)
        Alamofire.request(.POST,
            "http://contractssl.buildersaccess.com/bacontract_UpdVersion.json",
            parameters: a).responseJSON{ (response) -> Void in
                //                self.refreshControl?.endRefreshing()
                if response.result.isSuccess {
                    //
                    //                    if let rtnValue = response.result.value {
                    //                        print(rtnValue)
                    ////
                    //                    }else{
                    //
                    //                    }
                    self.navigationController?.popViewControllerAnimated(true)
                }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Update"
        Vname.text = info!["xname"]! + " == " + info!["xvalue"]!
        let today = NSDate()
        
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        
        Vvalue.text = formatter.stringFromDate(today)
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
