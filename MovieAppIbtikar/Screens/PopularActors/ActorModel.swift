//
//  ActorModel.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation


class ActorModel: ActorModelProtocol  {
    
    
    var persons = [Person]()
    let networkService = JsonDownload()
    
    var updateUI : ((_ result:[Person])->())?
    var updateImage : ((_ resultImage:Data)->())?
    
    init(){
        networkService.onCompleteJason = { result in
            print("eeee"+"\(result)")
            
            do{
                self.persons = []
                //created the json decoder
                let decoder = JSONDecoder()
                
                //using the array to put values
              
           let pp = try decoder.decode(ApiResponse.self, from: result)
                self.persons = pp.results!
                
                
                self.updateUI?(self.persons)
                
            }catch let err{
                print(err)
            }
        }
        
        networkService.onCompleteImage = {imageData in
            if imageData != nil
            {
                let data = imageData
                
                self.updateImage!(data)
      }}
        
        
        
    }
    
    
    func requestURL(url: String, pageNo: Int, completion: @escaping ([Person]) -> ()) {
        updateUI = completion
         networkService.downloadJason(urlJsonString: url,page:pageNo )
    }
    
    func requestImageURL(url: String, completion: @escaping (Data) -> ()) {
        updateImage = completion
        networkService.get_image(url)
    }
    
}
