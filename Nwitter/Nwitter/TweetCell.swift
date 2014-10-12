//
//  TweetCell.swift
//  Nwitter
//
//  Created by Ishmeet Singh on 10/11/14.
//  Copyright (c) 2014 iSingh. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {


    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
