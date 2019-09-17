//
//  CustomCell.swift
//  MovieAppIbtikar
//
//  Created by Lost Star on 9/1/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//


import UIKit

class CustomCell: UICollectionViewCell,DetailsCollectionViewCellProtocol {
    @IBOutlet var collectionImage: UIImageView!
    
    func displayProfilesImage(imgData: Data) {
        getImage(actorImageView: collectionImage , imageData: imgData)
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
