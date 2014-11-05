//
//  DetailDownload.swift
//  FreeboxClient
//
//  Created by Romain Hild on 05/11/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import UIKit

class DetailDownloadViewController: UIViewController {
    
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dir: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var created: UILabel!
    @IBOutlet weak var type: UILabel!
    @IBOutlet weak var state: UILabel!
    @IBOutlet weak var ratio: UILabel!
    @IBOutlet weak var send: UILabel!
    @IBOutlet weak var receive: UILabel!
    @IBOutlet weak var sendTo: UILabel!
    @IBOutlet weak var receiveFrom: UILabel!
    @IBOutlet weak var eta: UILabel!
    @IBOutlet weak var stopRatio: UILabel!
    @IBOutlet weak var priority: UILabel!
    @IBOutlet weak var error: UILabel!
    
    var dl: Download?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initLabels()
    }
    
    func initLabels() {
        self.name.text = dl!.name
        if let dirData = NSData(base64EncodedString: dl!.dir, options: NSDataBase64DecodingOptions.IgnoreUnknownCharacters) {
            self.dir.text = NSString(data: dirData, encoding: NSUTF8StringEncoding)
        }
        self.size.text = dl!.size.humanReadablePrec()
        self.created.text = String(dl!.created_ts)  //timestamp
        self.type.text = dl!.type                   //to french
        self.state.text = dl!.status                //to french
        let r: Float =  Float(dl!.tx_bytes) / Float(dl!.rx_bytes)
        self.ratio.text = String(format: "%.2f", r)
        self.send.text = dl!.tx_bytes.humanReadablePrec()
        self.receive.text = dl!.rx_bytes.humanReadablePrec()
        self.sendTo.text = dl!.tx_rate.humanReadable() + "/s"
        self.receiveFrom.text = dl!.rx_rate.humanReadable() + "/s"
        self.eta.text = dl!.eta.remainingTime()
        self.stopRatio.text = String(dl!.stop_ratio)
        self.priority.text = dl!.io_priority //to french
        self.error.text = dl!.error         //to french
    }
}

extension Int {
    func humanReadablePrec() -> String {
        var res = ""
        var unit = ""
        var tmp = Double(self)
        
        if self > 1000000000 {
            tmp /= 1000000000
            unit = "Go"
        }
        else if self > 1000000 {
            tmp /= 1000000
            unit = "Mo"
        }
        else if self > 1000 {
            tmp /= 1000
            unit = "Ko"
        }
        else {
            unit = "o"
        }
        
        if tmp > 100 {
            res = String(Int(tmp))
        }
        else if tmp > 10{
            res = String(format: "%.1f", tmp)
        }
        else {
            res = String(format: "%.2f", tmp)
        }
        
        return res + unit

    }
}
