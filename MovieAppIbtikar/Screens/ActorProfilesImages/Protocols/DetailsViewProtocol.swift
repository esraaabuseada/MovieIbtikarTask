//
//  DetailsViewProtocol.swift
//  MovieAppIbtikar
//
//  Created by user on 9/16/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import Foundation

protocol DetailsViewProtocol: class {
    func fetchingDataSuccess()
    //    func updateData()
    func reloadAll()
    func navigateToUserDetailsScreen(profiles:Profiles)
}
