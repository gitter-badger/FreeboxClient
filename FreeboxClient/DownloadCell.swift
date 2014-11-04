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

    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    func initItem(#name: String, size: String) {
        self.name.text = name
        self.size.text = size
    }
}
