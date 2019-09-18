//
//  SaveImagePresenter.swift
//  MovieAppIbtikar
//
//  Created by user on 9/18/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

class SaveImagePresenter {
    var imgData = Data()
    var saveModelProtocolObj: SaveImageModelProtocol?
    private weak var saveViewProtocolObj: SaveImageViewProtocol?
    var profileObj :Profiles?
    var  imageURL="https://image.tmdb.org/t/p/w500/"
   
    
    init(viewProtocol: SaveImageViewProtocol,modelProtocol: SaveImageModelProtocol) {
        saveViewProtocolObj = viewProtocol
        saveModelProtocolObj = modelProtocol
        print("i moved saaaveee")
        
    }
    
    
    func recivedDataFromModel() -> Profiles {
        profileObj = saveModelProtocolObj?.recievedData()
        return profileObj!
    }
    

    func getProfileImages(urlImage: String){
        saveModelProtocolObj!.requestImageURLProfile(url: urlImage, completion:{data  in
            self.imgData = data
           self.saveViewProtocolObj?.getImageDta(imgD: self.imgData)
          
            print(self.imgData,urlImage)
        })
         print(imgData,urlImage)
      
      
    
    }
    
    
    
}
