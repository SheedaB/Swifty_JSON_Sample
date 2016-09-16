//
//  SocialTableViewCell.swift
//  SwiftyJsonSample
//
//  Created by Rasheda Jacobs on 9/8/16.
//  Copyright © 2016 Rasheda Babatunde. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {

    
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var sharesText: UILabel!
    @IBOutlet weak var socialIcon: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
