//
//  WinnerTableViewCell.swift
//  DailyPicChallenge
//
//  Created by Laikh Tewari on 8/4/15.
//  Copyright (c) 2015 Laikh Tewari. All rights reserved.
//

import UIKit
import Parse

class WinnerTableViewCell: UITableViewCell {
    
    var winner: Winner!
    @IBOutlet weak var winnerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
