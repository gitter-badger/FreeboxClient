//
//  Freebox.swift
//  FreeboxClient
//
//  Created by Romain Hild on 26/10/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import Foundation

class Freebox {
    var name: String = "Freebox Server"
    var app_token: String
    
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
            freeboxes += [f]
        }
        return freeboxes
    }
    
    func toDictionnary() -> Dictionary<String,String> {
        return ["name":name, "token":app_token]
    }
}