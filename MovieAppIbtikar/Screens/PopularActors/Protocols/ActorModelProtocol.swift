//
//  ActorModelProtocol.swift
//  MovieAppIbtikar
//
//  Created by user on 9/16/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

protocol ActorModelProtocol: class {
    func requestURL (url: String ,pageNo:Int, completion: @escaping ([Person])  ->())
   // func requestImageURL (url: String,completion: @escaping (Data)  ->())
}
