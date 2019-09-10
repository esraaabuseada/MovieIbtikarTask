//
//  JsonDownload.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
class JsonDownload{
    
    var persons:[Person]=[]
    var onComplete: ((_ result: Data)->())?
    
    func downloadJason(urlJsonString:String) {
        //run animation, upon completion send callback
        let url = URL(string:urlJsonString)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            self.onComplete?(data!)
            
            
        }
        
        task.resume()
        
        
    }
    
    
//    func downloadJSON(urlJsonString:String) {
//        let url = URL(string:urlJsonString)
//
//        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
//
//            guard error == nil else {
//                print("returning error")
//                return
//            }
//
//            guard let content = data else {
//                print("not returning data")
//                return
//            }
//
//
//            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
//                print("Not containing JSON")
//                return
//            }
//
//
////            do{
////
////                //self.totalResults = json["total_results"] as! Int
////                let personsArray = json["results"] as? [Dictionary<String,Any>] ?? []
////                //print(personsArray)
////                //self.persons.removeAll()
////
////
////                for p in personsArray{
////                    let personObj=Person()
////                    personObj.name=p["name"] as? String ?? ""
////                    personObj.known_for_department=p["known_for_department"] as? String ?? ""
////                    personObj.profile_path=p["profile_path"] as? String ?? ""
////                    personObj.id=p["id"] as? Int ?? 0
////                    self.persons.append(personObj)
////                }
////
////                //self.updateData()
////
////
////            }
////            catch{
////                print("unable parse jason")
////            }
////
////
////
////
////
////
//      }
//
//        task.resume()
//
//    }
//
//
//
    
    
    
}
