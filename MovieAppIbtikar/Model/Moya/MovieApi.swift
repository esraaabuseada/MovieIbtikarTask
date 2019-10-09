//
//  MovieApi.swift
//  MovieAppIbtikar
//
//  Created by user on 10/9/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
import Moya




enum MovieApi{
    case popular(id : Int)
}
extension MovieApi : TargetType {
   
    
    var baseURL: URL {
         let url = URL(string: "https://api.themoviedb.org/3")
        return url!
    }
    
    var path: String {
        switch self {
        case .popular(let id):
            return "/person/\(id)/images"
            
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .popular:
            return .get
        }
    }
    
    var sampleData: Data {
        switch self {
        case .popular:
            return Data()
        }
    }
    
    var task: Task {
        switch self {
        case .popular(let id) :
            return .requestParameters(
        parameters: ["api_key":"cb8effcf3a0b27a05a7daba0064a32e1"],
                encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
}
}
