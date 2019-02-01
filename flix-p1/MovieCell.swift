//
//  MovieCell.swift
//  Flix-p1
//
//  Created by Myron on 1/29/19.
//  Copyright © 2019 Myron. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var SynopsisLabel: UILabel!
    @IBOutlet weak var PosterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
