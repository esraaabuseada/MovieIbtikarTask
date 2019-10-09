//
//  SaveImageModel.swift
//  MovieAppIbtikar
//
//  Created by user on 9/18/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

class SaveImageModel: SaveImageModelProtocol {
    
    
    var profiles:[Profiles]=[]
    let networkService = JsonDownload()
    var updateImageProfile : ((_ resultImageProfile:Data)->())?
    var profileDetailsViewObj = Profiles( file_path: "/n432vxKiMpgdCmOjq7UX6Gatisa.jpg")
   
    
    init(profileObj: Profiles){
        profileDetailsViewObj = profileObj
        
        networkService.onCompleteImage = {imageData  in
            if imageData != nil
            {
                let data = imageData
                self.updateImageProfile!(data)
            }}
    }
    
    
    func requestImageURLProfile(url: String, completion: @escaping (Data) -> ()) {
        updateImageProfile = completion
        networkService.get_image(url)
    }
    
    
    func recievedData() -> Profiles {
        return profileDetailsViewObj
    }
   
}
