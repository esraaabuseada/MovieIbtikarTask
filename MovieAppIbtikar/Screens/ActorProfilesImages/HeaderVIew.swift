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
}
