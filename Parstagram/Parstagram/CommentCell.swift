//
//  CommentCell.swift
//  Parstagram
//
//  Created by Myron on 3/12/19.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var CommentAurth: UILabel!
    @IBOutlet weak var CommentPost: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
