//
//  VersionListViewController.swift
//  Version
//
//  Created by April on 12/4/15.
//  Copyright © 2015 HapApp. All rights reserved.
//

import UIKit
import Alamofire

class VersionListViewController: UITableViewController, UISearchBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        getVersionList()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        refreshControl?.beginRefreshing()
        getVersionList()
        
    }
    @IBOutlet weak var searchBar: UISearchBar!
    var versionOrigin : [[String: String]]? {
        didSet{
            searchBar.text = ""
            versionList = versionOrigin
        }
    }
    var versionList : [[String: String]]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        versionList = versionOrigin?.filter(){
        return $0["xname"]!.lowercaseString.containsString(searchText)
        }
    }
    @IBAction func refresh() {
        self.getVersionList()
        
    }
    func getVersionList(){
        
        let a = ["version" : "0"]
        Alamofire.request(.POST,
            "http://contractssl.buildersaccess.com/bacontract_VersionList.json",
            parameters: a).responseJSON{ (response) -> Void in
                self.refreshControl?.endRefreshing()
                if response.result.isSuccess {
                    
                    if let rtnValue = response.result.value as? [[String: String]]{
                        self.versionOrigin = rtnValue
                    }else{
                        
                    }
                    
                }
        }
        
    }
   

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let v = versionList {
        return v.count
        }else{
        return 0
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let a: [String : String] = versionList![indexPath.row]
        cell.textLabel?.text = "\(a["xname"]!) == \( a["xvalue"]!)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let a: [String : String] = versionList![indexPath.row]
//        cell.textLabel?.text = "\(a["xname"]!) == \( a["xvalue"]!)"
        performSegueWithIdentifier("showUpdPage", sender: a)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let identifier = segue.identifier
        if identifier == "showUpdPage" {
            if let con = segue.destinationViewController as? UpdVersionViewController {
                if let a = sender as? [String : String]{
                    con.info = a
                }
                
            }
        }
    }
}
