//
//  ViewController.swift
//  FreeboxClient
//
//  Created by Romain Hild on 26/10/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,APIControllerProtocol {
    
    var api: APIController!
    var freeboxes = [Freebox]()
    var hasPermission = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        api = APIController(delegate: self)
        
        var defaults = NSUserDefaults.standardUserDefaults()

//        var appDomain = NSBundle.mainBundle().bundleIdentifier
//        defaults.removePersistentDomainForName(appDomain!)
//        
        if let tmpFreebox = defaults.arrayForKey("freeboxes") as? Array<Dictionary<String,String>> {
            freeboxes = Freebox.FreeboxWithArray(tmpFreebox)
            println(freeboxes)
        }
        else {
            api.authorize()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return freeboxes.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FreeboxIdentifier") as UITableViewCell
        cell.textLabel.text = freeboxes[indexPath.row].name
        cell.detailTextLabel?.text = freeboxes[indexPath.row].app_token
        return cell
    }
    
    func didReceiveAPIResults(jsonResults: NSDictionary, id_cmd: Int) {
        
        switch id_cmd {
        case 1:
            if jsonResults["success"] as Bool == true {
                let results = jsonResults["result"] as NSDictionary
                let token = results["app_token"] as? String
                let trackId = results["track_id"] as? Int
                
                alertWithTrackId(trackId!, app_token:token!)
            }
        case 2:
            if jsonResults["success"] as Bool == true {
                let results = jsonResults["result"] as NSDictionary
                if results["status"] as String == "granted" {
                    hasPermission = true
                }
            }
        default:
            println("command unknown")
        }
    }
    
    func alertWithTrackId(id: Int, app_token token: String) {
        var alert = UIAlertController(title: "Demande de permission", message: "Vous devez autorisez l'application depuis l'écran LCD de la Freebox Server", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Annuler", style: .Cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Réessayer", style: .Default, handler: {action -> Void in
            self.api.track(id)
            if self.hasPermission == false {
                self.alertWithTrackId(id, app_token: token)
            }
            else {
                //creer Freebox
                var name = "Freebox Server"
                
                var nameAlert = UIAlertController(title: "Nom de la Freebox", message: "Entrez un nom pour la Freebox", preferredStyle: .Alert)
                nameAlert.addTextFieldWithConfigurationHandler({textfield in
                    textfield.text = name
                })
                
                nameAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: {action -> Void in
                    let tf = nameAlert.textFields?.first as UITextField
                    name = tf.text as String
                    var freebox = Freebox(name: name, token: token)
                    
                    var dictFreebox: Array<Dictionary<String,String>>?
                    var defaults = NSUserDefaults.standardUserDefaults()
                    if let tmpFreebox = defaults.arrayForKey("freeboxes") as? Array<Dictionary<String,String>> {
                        dictFreebox = tmpFreebox + [freebox.toDictionnary()]
                    }
                    else {
                        dictFreebox = [freebox.toDictionnary()]
                    }
                    defaults.setObject(dictFreebox, forKey: "freeboxes")
                    
                    self.freeboxes += [freebox]
                    self.api.login()
                }))
                
                self.presentViewController(nameAlert, animated: true, completion: nil)
            }
        }))
        
        self.presentViewController(alert, animated: true, completion: nil)
    }

}

