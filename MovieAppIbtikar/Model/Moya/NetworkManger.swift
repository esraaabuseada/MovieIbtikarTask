//
//  NetworkManger.swift
//  MovieAppIbtikar
//
//  Created by user on 10/9/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
import  Moya

class NetworkManager{
    let appNetworkProvider = MoyaProvider<MovieApi>(plugins: [NetworkLoggerPlugin(verbose:true)])
    
//    appNetworkProvider.request(.popular(id: id)) { (response) in
//    switch response.result {
//
//
//    case .success(let value):
//    let decoder = JSONDecoder()
//    do {
//    let posts = try decoder.decode([Post].self, from: value.data)
//    completion(posts, nil)
//    }
}
