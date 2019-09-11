//
//  ActorTableViewCell.swift
//  MovieAppIbtikar
//
//  Created by user on 9/11/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell {

    @IBOutlet weak var actorImage: UIImageView!
    
    @IBOutlet weak var actorName: UILabel!
    
    @IBOutlet weak var actorKnown: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
