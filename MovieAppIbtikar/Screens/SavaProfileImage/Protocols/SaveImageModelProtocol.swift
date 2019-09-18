//
//  SaveImageModelProtocol.swift
//  MovieAppIbtikar
//
//  Created by user on 9/18/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

protocol SaveImageModelProtocol: class {
    func requestImageURLProfile (url: String,completion: @escaping (Data)  ->())
    func recievedData()->Profiles
}
