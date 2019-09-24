//
//  TestModel.swift
//  MovieAppIbtikarTaskTests
//
//  Created by user on 9/23/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

@testable import MovieAppIbtikar

class  TestModel: ActorModelProtocol {
    var updateUI : ((_ result:[Person])->())?
    
     var persons:[Person]=[]
    var path = ""
    func requestURL(url: String, pageNo: Int, completion: @escaping ([Person]) -> ()) {
        print("urllllll" + url)
        let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("Not containing JSON")
            return
        }
        
        do{
            self.persons = []
            let personsArray = json["results"] as? [Dictionary<String,Any>] ?? []
            for p in personsArray{
                let personObj=Person()
                personObj.name=p["name"] as? String ?? ""
                personObj.known_for_department=p["known_for_department"] as? String ?? ""
                personObj.profile_path=p["profile_path"] as? String ?? ""
                personObj.id=p["id"] as? Int ?? 0
                self.persons.append(personObj)
            }
            
            completion(self.persons)
            
        }
        
          updateUI = completion
        
        
    }
    
    func requestImageURL(url: String, completion: @escaping (Data) -> ()) {
        
    }
    
    
}
