//
//  TestView.swift
//  MovieAppIbtikarTaskTests
//
//  Created by user on 9/23/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

@testable import MovieAppIbtikar
class TestView : ActorViewProtocol{
    var tableLoaded :Bool!
    func fetchingDataSuccess() {
        tableLoaded = true
      assert(tableLoaded == true)
    }
    
    func reloadAll() {
         print("realoddata")
        
    }
    
    func navigateToUserDetailsScreen(person: Person) {
         print("tableviewnavigation")
        
    }
    
    func getImageDta(imgD: Data) {
         print("tableviewimage")
        
    }
    
    
}
