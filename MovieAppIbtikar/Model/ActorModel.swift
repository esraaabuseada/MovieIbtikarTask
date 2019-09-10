//
//  ActorModel.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

class ActorModel {
    var persons:[Person]=[]
    let networkService = JsonDownload()
    
    
    
    
    var onComplete: ((_ result: [Person])->())?
    
    func fetchDataFromUrl(url: String) {
          
    }
    
   func parseJSON()->[Person]{
    networkService.onComplete = { data in
        
      
        guard let json = (try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
            print("Not containing JSON")
            return
        }
        do{
            
                            //self.totalResults = json["total_results"] as! Int
                            let personsArray = json["results"] as? [Dictionary<String,Any>] ?? []
                            //print(personsArray)
                            //self.persons.removeAll()
            
            
                            for p in personsArray{
                                let personObj=Person()
                                personObj.name=p["name"] as? String ?? ""
                                personObj.known_for_department=p["known_for_department"] as? String ?? ""
                                personObj.profile_path=p["profile_path"] as? String ?? ""
                                personObj.id=p["id"] as? Int ?? 0
                                self.persons.append(personObj)
                            }
            
                            //self.updateData()
            
            
                        }
                        catch{
                            print("unable parse jason")
                        }
            
    
    }
    return persons
}
    
    
}
