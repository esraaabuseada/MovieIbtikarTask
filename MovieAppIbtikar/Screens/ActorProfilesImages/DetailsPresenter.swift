//
//  DetailsPresenter.swift
//  MovieAppIbtikar
//
//  Created by user on 9/16/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

class DetailsPresenter {
    var imgData = Data()
    var imgProfilesData = Data()
    
    var detailsModelProtocolObj: DetailsModelProtocol?
    private weak var detailsViewProtocolObj: DetailsViewProtocol?
    var personObj :Person?
    var pageNumber:Int=1
  var profilesArray:[Profiles] = []
    var  imageURL="https://image.tmdb.org/t/p/w500/"
    var id = ""
    
    init(viewProtocol: DetailsViewProtocol,modelProtocol: DetailsModelProtocol) {
       detailsViewProtocolObj = viewProtocol
        detailsModelProtocolObj = modelProtocol
        print("i moved")
        
    }
    
    
    func recivedDataFromModel() -> Person {
      personObj = detailsModelProtocolObj?.recievedData()
        
        return personObj!
    }
    
    func viewDidLoad(id :String) {
       
       var  urlString = "https://api.themoviedb.org/3/person/" + id + "/images?api_key=cb8effcf3a0b27a05a7daba0064a32e1"
        
        detailsModelProtocolObj!.requestURLProfile(url:urlString,completion: { result in
                    print(result)
                    self.profilesArray = result
           
            print(self.profilesArray)
            
                   self.detailsViewProtocolObj!.fetchingDataSuccess()
            
                })
    }
    
    func didSelectRow(index: Int) {
        let profiless = profilesArray[index]
        
        detailsViewProtocolObj?.navigateToUserDetailsScreen(profiles: profiless)
    }
    
    
    func getProfilesCount() -> Int {
        return profilesArray.count
    }
    
    func ProfilesArrayMethod()-> [Profiles]{
        return profilesArray
    }
    
    func getProfileImages(urlImage: String)->Data{
        detailsModelProtocolObj!.requestImageURLProfile(url: urlImage, completion:{dataResult  in
            self.imgData = dataResult})
print(self.imgData)

        return self.imgData
    }
    
    
    func getImages(){
        var urlImage = imageURL + personObj!.profile_path!
        detailsModelProtocolObj!.requestImageURLProfile(url: urlImage, completion:{dataResult  in
            self.imgData = dataResult})
    }
    
    func configureHeader(header: DetailsHeaderProtocol, for index: Int) {
        //let profile = profilesArray[index]
        getImages()
        header.displayName(name: personObj!.name!)
        header.displaypersonImage(imgd: imgData)
    }
    
    func configureCell(cell: DetailsCollectionViewCellProtocol, for index: Int,profiles: Profiles,imgData:Data) {
        cell.displayProfilesImage(imgData: imgData)
    }
    
}
