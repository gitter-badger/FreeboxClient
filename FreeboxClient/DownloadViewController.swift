//
//  DownloadViewController.swift
//  FreeboxClient
//
//  Created by Romain Hild on 28/10/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, APIControllerProtocol {

    @IBOutlet weak var downloadTableView: UITableView!
    
    var free: Freebox?
    var sessionToken : String?
    var api: APIController!
    var downloads = [Download]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIController(token: self.sessionToken!, delegate: self)
        api.downloads()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return downloads.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("downloadIdentifier") as UITableViewCell
        let dl = downloads[indexPath.row]
        cell.textLabel.text = dl.name
        if let dirData = NSData(base64EncodedString: dl.dir, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters) {
            cell.detailTextLabel?.text = NSString(data: dirData, encoding: NSUTF8StringEncoding)
        }
        return cell
    }
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        let dl = downloads[indexPath.row]
//        println(dl.dir)
//    }
    
    func didReceiveAPIResults(jsonResults: NSDictionary, id_cmd: Int) {
        switch id_cmd {
        case 0:
            if jsonResults["success"] as Bool == true {
                let results = jsonResults["result"] as Array<Dictionary<String,AnyObject>>
                downloads = Download.DownloadsWithArray(results)
                downloadTableView.reloadData()
            }
        default:
            println("command unknown")
        }

    }

}
