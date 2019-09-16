//
//  DetailsModelProtocole.swift
//  MovieAppIbtikar
//
//  Created by user on 9/16/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

protocol DetailsModelProtocol: class {
   func requestURLProfile (url: String , completion: @escaping ([Profiles])  ->())
    func requestImageURLProfile (url: String,completion: @escaping (Data)  ->())
    func recievedData()->Person
}
