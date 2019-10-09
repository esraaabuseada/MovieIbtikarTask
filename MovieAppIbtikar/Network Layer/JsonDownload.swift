//
//  JsonDownload.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation
import  Alamofire

class JsonDownload{
    
    var onCompleteJason: ((_ result: Data)->())?
    var onCompleteImage: ((_ imageData: Data)->())?
    var onCompleteJasonProfile: ((_ resultProfile: Data)->())?
    var onCompleteImageProfile: ((_ imageDataProfile: Data)->())?
    
    func downloadProfilesJson(urlJsonString:String) {
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
            
            self.onCompleteJasonProfile?(data!)
        }
        task.resume()
    }
    
    
    func downloadJason(urlJsonString:String,page:Int) {
        Alamofire.request(urlJsonString, method: .get,parameters:["page" : page] ).responseJSON{ (response) in
            print(response)
            
                guard let data = response.data
                    
                    else {return}
            self.onCompleteJason?(response.data!)
               
                
            
            
        }
        
        
        
    }
    
    
    
    func get_image(_ url_str:String)
    {
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            
            self.onCompleteImage?(data!)})
        task.resume()
    }
    
    
    
    

    
    
    
}
