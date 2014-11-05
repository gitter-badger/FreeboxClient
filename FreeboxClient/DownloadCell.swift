//
//  DownloadCell.swift
//  FreeboxClient
//
//  Created by Romain Hild on 04/11/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var state: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var upDown: UILabel!
    @IBOutlet weak var pct: UILabel!
    @IBOutlet weak var eta: UILabel!

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func initDownload(dl: Download) {
        self.name.text = dl.name
        switch dl.status {
        case "downloading","queued","starting":
            self.state.image = UIImage(named: "down")
            self.pct.text = String(Int(dl.rx_pct/100)) + "%"
            self.eta.text = dl.eta.remainingTime()
        case "done","seeding":
            self.state.image = UIImage(named: "up")
            self.pct.text = String(Int(dl.tx_pct/100)) + "%"
        case "stopped","stopping":
            self.state.image = UIImage(named: "pause")
            self.pct.text = String(Int(dl.rx_pct/100)) + "%"
        default:
            self.state.image = UIImage(named: "stop")
            self.pct.text = String(Int(dl.rx_pct/100)) + "%"
        }
        self.size.text = dl.size.humanReadable()
        self.progress.progress = Float(dl.rx_pct) / 10000

        let down = dl.rx_rate.humanReadable()
        let up = dl.tx_rate.humanReadable()
        self.upDown.text = down + "/" + up
        var text = NSMutableAttributedString(attributedString: self.upDown.attributedText)
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.greenColor(), range: NSMakeRange(0, countElements(down)))
        text.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(countElements(down)+1, countElements(up)))
        self.upDown.attributedText = text
    }
}

extension Int {
    func humanReadable() -> String {
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
        
        if tmp > 10 {
            res = String(Int(tmp))
        }
        else {
            res = String(format: "%.1f", tmp)
        }
        
        return res + unit
    }
    
    func remainingTime() -> String {
        var res = ""
        var s = self
        var h = 0, m = 0
        
        if s > 3600 {
            h = s / 3600
            s %= 3600
        }
        if s > 60 {
            m = s / 60
            s %= 60
        }

        if h > 0 {
            res = res + String(h) + "h"
            if m > 0 {
                res = res + String(m) + "m"
            }
        }
        else {
            if m > 0 {
                res = res + String(m) + "m"
            }
            if s > 0 {
                res = res + String(s) + "s"
            }
        }
        return res
    }
}
