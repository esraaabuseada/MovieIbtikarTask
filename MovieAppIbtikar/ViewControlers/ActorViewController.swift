//
//  ActorViewController.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class ActorViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    

    @IBOutlet weak var actorsTableview: UITableView!
    
    var pageNumber:Int=1
    var totalResults = 0
    var generalURL = "https://api.themoviedb.org/3/person/popular?api_key=cb8effcf3a0b27a05a7daba0064a32e1&page="
    var searchURL = "https://api.themoviedb.org/3/person/popular?api_key=cb8effcf3a0b27a05a7daba0064a32e1&page=&query="
    var  imageURL="https://image.tmdb.org/t/p/w500/"
    var personsArray:[Person]=[]
    
    let actorModelObj = ActorModel()
    
         
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actorModelObj.requestURL(url: generalURL, completion: { _result in
            self.personsArray = _result
            print(_result)
            self.updateData()
            
        })
        

        // Do any additional setup after loading the view.
    }
    func updateData(){
        DispatchQueue.main.async {
           self.actorsTableview.reloadData()
        }
        
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personsArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as? ActorTableViewCell
        
        // Configure the cell...
        cell?.actorName.text=personsArray[indexPath.row].name
        cell?.actorKnown.text=personsArray[indexPath.row].known_for_department
        
        
        
        return cell!
    }
    

    

}
