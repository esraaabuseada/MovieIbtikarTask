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
    
    
    
    var updateUI : ((_ result:[Profiles])->())?
    var updateImage : ((_ resultImage:Data,_ resultImageView:UIImageView)->())?
    
    init(){
        
        
        networkService.onCompleteJason = { result in
            guard let json = (try? JSONSerialization.jsonObject(with: result, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
                
            }
            
            do{
                
             
                let profilesArray = json["profiles"] as? [Dictionary<String,Any>] ?? []
                
             // self.profiles.removeAll()
              
                
                
                for p in profilesArray{
                    var profileObj=Profiles()
                    
                    profileObj.file_path=p["file_path"] as? String ?? ""
                    
                    self.profiles.append(profileObj)
                    
                }
                
                
                //self.updateData()
                self.updateUI!(self.profiles)
                
            }
            catch{
                print("unable parse jason")
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
    
    func requestURL (url: String , completion: @escaping ([Profiles])  ->()){
        updateUI = completion
        networkService.downloadProfilesJson(urlJsonString: url)
        
    }
    
    
    func requestImageURL (url: String,imageD:UIImageView,completion: @escaping (Data,UIImageView)  ->()){
        updateImage = completion
        networkService.get_image(url,imageDownloded: imageD)
    }
    
    
    
    
}
