//
//  DetailsPresenter.swift
//  MovieAppIbtikar
//
//  Created by user on 9/16/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

class DetailsPresenter {
    
    var detailsModelProtocolObj: DetailsModelProtocol?
    private weak var detailsViewProtocolObj: DetailsViewProtocol?
    var personObj :Person?
    var pageNumber:Int=1
  var profilesArray:[Profiles]=[]
    var  imageURL="https://image.tmdb.org/t/p/w500/"
    
    init(viewProtocol: DetailsViewProtocol,modelProtocol: DetailsModelProtocol) {
       detailsViewProtocolObj = viewProtocol
        detailsModelProtocolObj = modelProtocol
        print("i moved")
        
    }
    
    
    func recivedDataFromModel() -> Person {
      personObj = detailsModelProtocolObj?.recievedData()
        
        return personObj!
    }
    
    func viewDidLoad() {
       
       let  urlString = "https://api.themoviedb.org/3/person/" + "\(personObj?.id)" + "/images?api_key=cb8effcf3a0b27a05a7daba0064a32e1"
        
        detailsModelProtocolObj!.requestURLProfile(url:urlString,completion: { _result in
                    print(_result)
                    self.profilesArray = _result
                   self.detailsViewProtocolObj!.fetchingDataSuccess()
            
                })
    }
    
    func getProfilesCount() -> Int {
        return profilesArray.count
    }
    
    func configure(header: DetailsHeaderProtocol, for index: Int) {
        //let profile = profilesArray[index]
        header.displayName(name: personObj!.name)
        
    }
    
    
}
