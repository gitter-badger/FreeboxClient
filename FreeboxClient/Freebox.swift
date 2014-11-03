//
//  Freebox.swift
//  FreeboxClient
//
//  Created by Romain Hild on 26/10/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import Foundation

class Freebox {
    var name: String
    var app_token: String
    var remote_ip: String?
    var remote_port: String?
    
    init(name: String, token: String) {
        self.name = name
        self.app_token = token
    }
    
    class func FreeboxWithArray(array: Array<Dictionary<String,String>>) -> [Freebox] {
        var freeboxes = [Freebox]()
        for freebox in array {
            let n = freebox["name"]
            let t = freebox["token"]
            let f: Freebox = Freebox(name: n!, token: t!)
            if let rip = freebox["remote_ip"] as String? {
                f.remote_ip = rip
            }
            if let rport = freebox["remote_port"] as String? {
                f.remote_port = rport
            }
            freeboxes += [f]
        }
        return freeboxes
    }
    
    func toDictionnary() -> Dictionary<String,String> {
        var dict = Dictionary<String,String>()
        dict["name"] = name
        dict["token"] = app_token
        if let rip = remote_ip {
            dict["remote_ip"] = rip
        }
        if let rport = remote_port {
            dict["remote_port"] = rport
        }
        return dict
    }
}