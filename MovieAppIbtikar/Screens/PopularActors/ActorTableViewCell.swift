//
//  ActorTableViewCell.swift
//  MovieAppIbtikar
//
//  Created by user on 9/11/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class ActorTableViewCell: UITableViewCell ,ActorTableViewCellProtocol {
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    @IBOutlet weak var actorKnown: UILabel!
    var imageData :Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayName(name: String) {
        actorName.text = name
    }
    
    func displayKnowFor(knownFor: String) {
        actorKnown.text = knownFor
    }
    
    func displayImage(imgData: Data) {
        imageData = imgData
        getImage(actorImageView: actorImage, imageData: imageData!)
    }
    

    
    func  getImage(actorImageView:UIImageView,imageData:Data ) {
        if imageData != nil
        {
            let image = UIImage(data: imageData)
            
            
            if(image != nil)
            {
                
                DispatchQueue.main.async(execute: {
                    
                    actorImageView.image = image
                    actorImageView.alpha = 0
                    
                    
                    UIView.animate(withDuration: 2.5, animations: {
                        actorImageView.alpha = 1.0
                    })
                    
                })
                
            }
            
        }
        
    }
    
    
}
