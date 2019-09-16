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
    var pageNumber:Int=1
    var totalResults = 0
    
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
    
    
    func getActorsCount() -> Int {
        return personsArray.count
    }
    
    func configure(cell: ActorTableViewCellProtocol, for index: Int) {
        let person = personsArray[index]
        cell.displayName(name: person.name)
        cell.displayKnowFor(knownFor: person.known_for_department)
    }
    
    func didSelectRow(index: Int) {
      let person = personsArray[index]
        actorViewProtocolObj?.navigateToUserDetailsScreen(person: person)
    }
   
    
}
