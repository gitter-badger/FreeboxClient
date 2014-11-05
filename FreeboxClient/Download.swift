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
    var type: String
    var name: String
    var status: String
    var size: Int
    var queue_pos: Int
    var io_priority: String
    var tx_bytes: Int
    var rx_bytes: Int
    var tx_rate: Int
    var rx_rate: Int
    var tx_pct: Int
    var rx_pct: Int
    var error: String
    var created_ts: Int
    var eta: Int
    var dir: String
    var stop_ratio: Int
    
    init(id: Int, type: String, name: String, status: String, size: Int, queue_pos: Int, io_priority: String,tx_bytes: Int, rx_bytes: Int, tx_rate: Int, rx_rate: Int, tx_pct: Int, rx_pct: Int, error: String, created_ts: Int, eta: Int, dir: String, stop_ratio: Int){
        self.id = id
        self.type = type
        self.name = name
        self.status = status
        self.size = size
        self.queue_pos = queue_pos
        self.io_priority = io_priority
        self.tx_bytes = tx_bytes
        self.rx_bytes = rx_bytes
        self.tx_rate = tx_rate
        self.rx_rate = rx_rate
        self.tx_pct = tx_pct
        self.rx_pct = rx_pct
        self.error = error
        self.created_ts = created_ts
        self.eta = eta
        self.dir = dir
        self.stop_ratio = stop_ratio
    }
    
    class func DownloadsWithArray(array: Array<Dictionary<String,AnyObject>>) -> [Download] {
        var dls = [Download]()
        for dl in array {
            let i = dl["id"] as Int
            let t = dl["type"] as String
            let n = dl["name"] as String
            let st = dl["status"] as String
            let s = dl["size"] as Int
            let q = dl["queue_pos"] as Int
            let io = dl["io_priority"] as String
            let tb = dl["tx_bytes"] as Int
            let rb = dl["rx_bytes"] as Int
            let tr = dl["tx_rate"] as Int
            let rr = dl["rx_rate"] as Int
            let tp = dl["tx_pct"] as Int
            let rp = dl["rx_pct"] as Int
            let e = dl["error"] as String
            let c = dl["created_ts"] as Int
            let et = dl["eta"] as Int
            let d = dl["download_dir"] as String
            let stop = dl["stop_ratio"] as Int
            var down = Download(id: i, type: t, name: n, status: st, size: s, queue_pos: q, io_priority: io,tx_bytes: tb, rx_bytes: rb, tx_rate: tr, rx_rate: rr, tx_pct: tp, rx_pct: rp, error: e, created_ts: c, eta: et, dir: d, stop_ratio: stop)
            dls += [down]
        }
        return dls
    }
}