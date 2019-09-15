//
//  DetailsModel.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
import UIKit

class DetailsModel {
    var profiles:[Profiles]=[]
    let networkService = JsonDownload()
    var updateUIProfile : ((_ resultProfile:[Profiles])->())?
    var updateImageProfile : ((_ resultImageProfile:Data,_ resultImageViewProfile:UIImageView)->())?
    
    init(){
        networkService.onCompleteJasonProfile = { resultProfile in
            guard let json = (try? JSONSerialization.jsonObject(with: resultProfile, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
                
            }
            
            do{
                
             
                let profilesArray = json["profiles"] as? [Dictionary<String,Any>] ?? []
                for p in profilesArray{
                    var profileObj=Profiles()
                    
                    profileObj.file_path=p["file_path"] as? String ?? ""
                    
                    self.profiles.append(profileObj)
                    
                }
                self.updateUIProfile!(self.profiles)
                
            }
            
        }
        
        networkService.onCompleteImage = {imageData ,imageView in
            if imageData != nil
            {
                let data = imageData
                let image = imageView
                self.updateImageProfile!(data,image)
            }}
    }

    func requestURLProfile (url: String , completion: @escaping ([Profiles])  ->()){
        updateUIProfile = completion
        networkService.downloadProfilesJson(urlJsonString: url)
        
    }

    func requestImageURLProfile (url: String,imageD:UIImageView,completion: @escaping (Data,UIImageView)  ->()){
        updateImageProfile = completion
        networkService.get_image(url,imageDownloded: imageD)
    }
}
