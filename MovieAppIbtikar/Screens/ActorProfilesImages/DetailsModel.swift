//
//  DetailsModel.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation


class DetailsModel: DetailsModelProtocol {
    var profiles:[Profiles]=[]
    let networkService = JsonDownload()
    var updateUIProfile : ((_ resultProfile:[Profiles])->())?
    var updateImageProfile : ((_ resultImageProfile:Data)->())?
   var personObjActorView = Person(id: 18918,profile_path: "/kuqFzlYMc2IrsOyPznMd1FroeGq.jpg",name: "Dwayne Johnson")
 
    
    init(personObj:Person){

        personObjActorView = personObj
     
        networkService.onCompleteJasonProfile = { resultProfile in
          
            
            do{
                self.profiles = []
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
                
                let profileJson = try decoder.decode(ApiProfileResponse.self, from: resultProfile)
                self.profiles = profileJson.profiles!
                
                
                self.updateUIProfile?(self.profiles)
            
                
            }catch let err{
                print(err)
            }
             
            
               
                
            
        }
        
    
        
        networkService.onCompleteImage = {imageData  in
            if imageData != nil
            {
                let data = imageData
                self.updateImageProfile!(data)
            }}
    }
    
    func requestURLProfile(id:Int, completion: @escaping ([Profiles]) -> ()) {
        updateUIProfile = completion
         networkService.getProfileResponse(id: id)
    }
    
    func requestImageURLProfile(url: String, completion: @escaping (Data) -> ()) {
        updateImageProfile = completion
         networkService.get_image(url)
    }
    
    func recievedData()->Person{
        print(personObjActorView)
        
        return personObjActorView
    }
    
    
}
