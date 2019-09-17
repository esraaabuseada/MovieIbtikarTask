//
//  ActorPresenter.swift
//  MovieAppIbtikar
//
//  Created by user on 9/16/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

class ActorPresenter{
    var personsArray:[Person]=[]
    let actorModelProtocolObj: ActorModelProtocol?
    private weak var actorViewProtocolObj: ActorViewProtocol?
    private weak var detailsViewProtocolObj: DetailsViewProtocol?
    var  detailsPresente :DetailsPresenter?
    var pageNumber:Int=1
    var totalResults = 0
    var imgData = Data()
    var imgD = Data()
    var generalURL = "https://api.themoviedb.org/3/person/popular?api_key=cb8effcf3a0b27a05a7daba0064a32e1&page="
    var searchUrl = ""
    var  imageURL="https://image.tmdb.org/t/p/w500/"
    
    init(viewProtocol: ActorViewProtocol,modelProtocol: ActorModelProtocol) {
        actorViewProtocolObj = viewProtocol
        actorModelProtocolObj = modelProtocol
       
        
    }
    
    
    func viewDidLoad() {
        actorModelProtocolObj!.requestURL(url: generalURL,pageNo:pageNumber, completion: { _result in
            self.personsArray.append(contentsOf: _result)
            print(_result)
            self.actorViewProtocolObj?.fetchingDataSuccess()
        })
    }
    
    func PersonArrayMethod()-> [Person]{
        return personsArray
    }
    

    func getImages(urlImage: String)->Data{
        actorModelProtocolObj!.requestImageURL(url: urlImage, completion:{dataResult  in
            self.imgData = dataResult})
        
        
        return self.imgData
    }

    func getActorsCount() -> Int {
        return personsArray.count
    }
    
    func configure(cell: ActorTableViewCellProtocol, for index: Int,person:Person,imgData:Data) {
        cell.displayName(name: person.name)
        cell.displayKnowFor(knownFor: person.known_for_department)
        cell.displayImage(imgData: imgData )
    }
    
    func didSelectRow(index: Int) {
      let person = personsArray[index]
   
        actorViewProtocolObj?.navigateToUserDetailsScreen(person: person)
    }
    
    func loadMore(){
        pageNumber += pageNumber + 1
        actorModelProtocolObj!.requestURL(url: generalURL,pageNo:pageNumber, completion: { _result in
            self.personsArray.append(contentsOf: _result)
            print(_result)
            self.actorViewProtocolObj?.fetchingDataSuccess()
        })
    }
   
    
    
    func reloadUI(){
        self.pageNumber = 1
                self.personsArray = []
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.actorModelProtocolObj!.requestURL(url: self.generalURL,pageNo:self.pageNumber, completion: { _result in
                        self.personsArray.append(contentsOf: _result)
                        print(_result)
                        self.actorViewProtocolObj?.fetchingDataSuccess()
                    })
                   
                }
        
    
    }
    
    func searchURL(searchtext: String){
      searchUrl =  "https://api.themoviedb.org/3/search/person?api_key=3955a9144c79cb1fca10185c95080107&language=en-US&query=\(searchtext.replacingOccurrences(of:" ", with:"%20"))&include_adult=false&page="
        
    }
    
    func searchFunction(){
        personsArray.removeAll()
        pageNumber = 1
        actorModelProtocolObj!.requestURL(url: searchUrl,pageNo:pageNumber, completion: { _result in
            self.personsArray.append(contentsOf: _result)
            print(_result)
            self.actorViewProtocolObj?.fetchingDataSuccess()
        })
    }
    
}
