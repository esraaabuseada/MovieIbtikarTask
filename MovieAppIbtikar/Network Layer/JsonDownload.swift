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
    var onCompleteJason: ((_ result: Data)->())?
    var onCompleteImage: ((_ imageData: Data)->())?
    
    func downloadJason(urlJsonString:String,page:Int) {
        //run animation, upon completion send callback
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
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
//            if data != nil
//            {
//                let image = UIImage(data: data!)
//
//
//                if(image != nil)
//                {
//
//                    DispatchQueue.main.async(execute: {
//
//                        imageView.image = image
//                        imageView.alpha = 0
//
//                        UIView.animate(withDuration: 2.5, animations: {
//                            imageView.alpha = 1.0
//                        })
//
//                    })
//
//                }
            
            //}
            
            self.onCompleteImage?(data!)
        })
        
        task.resume()
    }
    
    
    

    
    
    
}
