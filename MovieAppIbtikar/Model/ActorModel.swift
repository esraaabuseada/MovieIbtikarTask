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
    
    
    
    var updateUI : ((_ result:[Person])->())?
     var updateImage : ((_ resultImage:Data)->())?
    
    init(){
        networkService.onCompleteJason = { result in
            guard let json = (try? JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
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
                self.updateUI!(self.persons)
                
            }
            catch{
                print("unable parse jason")
            }
            
            
            
            
        }
        networkService.onCompleteImage = {imageData in
            if imageData != nil
                        {
                            let data = imageData
                            self.updateImage!(data)
//                            let image = UIImage(data: data!)
//
//
//                            if(image != nil)
//                            {
//
//                                DispatchQueue.main.async(execute: {
//
//                                    imageView.image = image
//                                    imageView.alpha = 0
//
//                                    UIView.animate(withDuration: 2.5, animations: {
//                                        imageView.alpha = 1.0
//                                    })
//
//                                })
//
//                            }
            
            }}
    

    }
    func requestURL (url: String ,pageNo:Int, completion: @escaping ([Person])  ->()){
        updateUI = completion
         networkService.downloadJason(urlJsonString: url,page:pageNo )
    }
    
    
    func requestImageURL (url: String,completion: @escaping (Data)  ->()){
        updateImage = completion
        networkService.get_image(url)
    }
    
    
    

}
