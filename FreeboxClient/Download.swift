//
//  Downloads.swift
//  FreeboxClient
//
//  Created by Romain Hild on 03/11/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import Foundation

class Download {
    var id: Int
    var name: String
    var size: Int
    var status: String
    var dir: String
    
    init(id: Int, name: String, size: Int, status: String, dir: String){
        self.id = id
        self.name = name
        self.size = size
        self.status = status
        self.dir = dir
    }
    
    class func DownloadsWithArray(array: Array<Dictionary<String,AnyObject>>) -> [Download] {
        var dls = [Download]()
        for dl in array {
            let i = dl["id"] as Int
            let n = dl["name"] as String
            let s = dl["size"] as Int
            let st = dl["status"] as String
            let d = dl["download_dir"] as String
            var down = Download(id: i, name: n, size: s, status: st, dir: d)
            dls += [down]
        }
        return dls
    }
}