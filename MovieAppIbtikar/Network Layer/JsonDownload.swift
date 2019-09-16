//
//  JsonDownload.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation


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
        let urlString=urlJsonString+"\(page)"
        let url = URL(string:urlString)
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            self.onCompleteJason?(data!)
        }
        task.resume()
    }
    
    
    
    func get_image(_ url_str:String)
    {
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in self.onCompleteImage?(data!)})
        task.resume()
    }
    
    
    
    

    
    
    
}
