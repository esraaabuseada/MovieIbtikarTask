//
//  Person.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

import ObjectMapper

struct Person : Mappable {
    var id : Int?
    var profile_path : String?
    var name : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        profile_path <- map["profile_path"]
        name <- map["name"]
}
    
    init(id :Int , profile_path : String, name : String){
        
                self.id = id
                self.profile_path = profile_path
                self.name = name
            }
}

//struct Person : Codable {
//    let id : Int?
//    let profile_path : String?
//    let name : String?
//
//    enum CodingKeys: String, CodingKey {
//        case id = "id"
//        case profile_path = "profile_path"
//        case name = "name"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        profile_path = try values.decodeIfPresent(String.self, forKey: .profile_path)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//    }
//
//    init(id :Int , profile_path : String, name : String){
//
//        self.id = id
//        self.profile_path = profile_path
//        self.name = name
//    }
//}
