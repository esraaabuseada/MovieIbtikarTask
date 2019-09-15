//
//  ActorModel.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
import UIKit

class ActorModel {
    var persons:[Person]=[]
    let networkService = JsonDownload()
    var updateUI : ((_ result:[Person])->())?
    var updateImage : ((_ resultImage:Data,_ resultImageView:UIImageView)->())?
    
    init(){
        networkService.onCompleteJason = { result in
            guard let json = (try? JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            do{
                let personsArray = json["results"] as? [Dictionary<String,Any>] ?? []
                self.persons = []
                for p in personsArray{
                    let personObj=Person()
                    personObj.name=p["name"] as? String ?? ""
                    personObj.known_for_department=p["known_for_department"] as? String ?? ""
                    personObj.profile_path=p["profile_path"] as? String ?? ""
                    personObj.id=p["id"] as? Int ?? 0
                    self.persons.append(personObj)
                }
    
                self.updateUI!(self.persons)
                
            }
                
           
        }
        
        networkService.onCompleteImage = {imageData ,imageView in
            if imageData != nil
            {
                let data = imageData
                let image = imageView
                self.updateImage!(data,image)
            }}
    }
    
    func requestURL (url: String ,pageNo:Int, completion: @escaping ([Person])  ->()){
        
        updateUI = completion
        networkService.downloadJason(urlJsonString: url,page:pageNo )
        
    }

    func requestImageURL (url: String,imageD:UIImageView,completion: @escaping (Data,UIImageView)  ->()){
        updateImage = completion
        networkService.get_image(url,imageDownloded: imageD)
    }
}
