//
//  DownloadCell.swift
//  FreeboxClient
//
//  Created by Romain Hild on 03/11/2014.
//  Copyright (c) 2014 Romain Hild. All rights reserved.
//

import UIKit

class DownloadCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dlSize: UILabel!
    @IBOutlet weak var percentage: UILabel!
    @IBOutlet weak var tx: UILabel!
    @IBOutlet weak var state: UIImageView!
    @IBOutlet weak var progress: UIProgressView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}