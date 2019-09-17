//
//  HeaderVIew.swift
//  MovieAppIbtikar
//
//  Created by Lost Star on 9/1/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
import UIKit

class HeaderVIew: UICollectionReusableView,DetailsHeaderProtocol {
    
    
    
    @IBOutlet var headerImage: UIImageView!
    
    
    @IBOutlet var headerLabel: UILabel!
    
    func displayName(name: String) {
        headerLabel.text = name
    }
    
    func displaypersonImage(imgd: Data) {
        getImage(actorImageView: headerImage, imageData: imgd)
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
