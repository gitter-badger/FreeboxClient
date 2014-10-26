//
//  APIController.swift
//  FreeboxClient
//
//  Created by Romain Hild on 26/10/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import Foundation

class APIController {
    
    let freeUrlString = "http://mafreebox.freebox.fr"
    var delegate: APIControllerProtocol
    
    init(delegate: APIControllerProtocol){
        self.delegate = delegate
    }
    
    func post(urlString: String, withParameters params: NSDictionary, id_cmd: Int) {
        let url = NSURL(string: urlString)
        var request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
        var err: NSError?
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: {data, response, error -> Void in
            if error != nil {
                println(error.localizedDescription)
            }
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if err != nil {
                println("JSON Error: \(err?.localizedDescription)")
            }
            
            self.delegate.didReceiveAPIResults(jsonResult, id_cmd: id_cmd)
        })
        
        task.resume()
    }
    
    func get(urlString: String, id_cmd: Int) {
        let url = NSURL(string: urlString)
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!, completionHandler: {data, response, error -> Void in
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            }
            var err: NSError?
            
            var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &err) as NSDictionary
            if(err != nil) {
                // If there is an error parsing JSON, print it to the console
                println("JSON Error \(err!.localizedDescription)")
            }
            
            self.delegate.didReceiveAPIResults(jsonResult, id_cmd: id_cmd)
        })
        
        task.resume()
    }
    
    func search() {
        let urlString = freeUrlString + "/api_version"
        get(urlString, id_cmd: 0)
    }

    func authorize() {
        
        let urlString = freeUrlString + "/api/v3/login/authorize/"
        var params = ["app_id":"freeboxclient", "app_name":"FreeboxClient", "app_version":"0.1", "device_name":"IphoneSimulator"] as Dictionary
        post(urlString, withParameters: params, id_cmd: 1)
    }
    
    func track(id: Int) -> Bool {
        let urlString = freeUrlString + "/api/v3/login/authorize/" + String(id)
        get(urlString, id_cmd: 2)
        return true
    }
    
    func login() {
        
    }
}

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary, id_cmd: Int)
}
