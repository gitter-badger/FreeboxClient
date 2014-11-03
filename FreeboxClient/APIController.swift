//
//  APIController.swift
//  FreeboxClient
//
//  Created by Romain Hild on 03/11/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import Foundation

class APIController {
    let freeUrlString = "http://mafreebox.freebox.fr"
    let sessionToken: String
    var delegate: APIControllerProtocol
    
    init(token: String, delegate: APIControllerProtocol) {
        self.sessionToken = token
        self.delegate = delegate
    }
    
    func get(urlString: String, id_cmd: Int) {
        let url = NSURL(string: urlString)
        var sessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
        sessionConfiguration.HTTPAdditionalHeaders = ["X-Fbx-App-Auth":self.sessionToken]
        let session = NSURLSession(configuration: sessionConfiguration)
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
    
    func downloads() {
        let urlString = freeUrlString + "/api/v3/downloads/"
        get(urlString, id_cmd: 0)
    }
}

protocol APIControllerProtocol {
    func didReceiveAPIResults(results: NSDictionary, id_cmd: Int)
}