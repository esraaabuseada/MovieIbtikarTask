//
//  ActorViewController.swift
//  MovieAppIbtikar
//
//  Created by user on 9/10/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class ActorViewController: UIViewController,ActorViewProtocol,UITableViewDataSource,UITableViewDelegate , UISearchBarDelegate {

    @IBOutlet weak var actorsTableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var refreshControl: UIRefreshControl!
    var actorPresenter: ActorPresenter!
    var searchFlag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.searchBar.delegate = self
        actorPresenter = ActorPresenter(viewProtocol: self, modelProtocol: ActorModel())
        actorPresenter.viewDidLoad()
        
        //JsonData Callback
        
        
        //Refresh
        actorsTableview.refreshControl = UIRefreshControl()
        actorsTableview.refreshControl?.attributedTitle = NSAttributedString(string: "refresh")
        actorsTableview.refreshControl?.addTarget(self, action: #selector(refresh(sender:)), for: UIControl.Event.valueChanged)
        actorsTableview.addSubview(actorsTableview.refreshControl!)
    }
    
    //Refressh method
    @objc func refresh(sender:AnyObject) {

        reloadAll()
        actorsTableview.reloadData()
        sender.endRefreshing()

    }
    
    
    func reloadAll()
    {
       actorPresenter.reloadUI()
    }
    
    // sET Image
    func  getImage(actorImageView:UIImageView,imageData:Data ) {
        if imageData != nil
        {
            let image = UIImage(data: imageData)
            
            
            if(image != nil)
            {
                
                DispatchQueue.main.async(execute: {
                    
                    actorImageView.image = image
                    actorImageView.alpha = 0
                    
                    
                    UIView.animate(withDuration: 2.5, animations: {
                        actorImageView.alpha = 1.0
                    })
                    
                })
                
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actorPresenter.getActorsCount()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "actorCell", for: indexPath) as? ActorTableViewCell
        
        // Configure the cell...
        actorPresenter.configure(cell: cell!, for: indexPath.row)
        

        //put image inside cell
//        let urlImageString = imageURL + personsArray[indexPath.row].profile_path
//        
//
//        self.getImage(actorImageView: cell!.actorImage,imageData:self.imgData  )
        
        //Load More
        if(indexPath.row == actorPresenter.getActorsCount()-3 && actorPresenter.getActorsCount() != actorPresenter.totalResults){
            actorPresenter.loadMore()
            

            if(searchFlag == true){
                actorPresenter.viewDidLoad()
            }else{

                 actorPresenter.searchFunction()
            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! DetailsViewController
        let selectedCell = actorsTableview.cellForRow(at: indexPath) as? ActorTableViewCell
        
        actorPresenter.didSelectRow(index: indexPath.row)
        
      

    }
    
    
    
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.actorsTableview.reloadData()
        }
        
    }
    
    func navigateToUserDetailsScreen(person: Person) {
        let detailsviewController = self.storyboard?.instantiateViewController(withIdentifier: "dvc")
          as! DetailsViewController
        detailsviewController.detailsPresenter = DetailsPresenter(viewProtocol: detailsviewController ,modelProtocol: DetailsModel(personObj: person))
        navigationController?.pushViewController(detailsviewController, animated: true)
    }
    
    
    //Search
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if(!searchText.isEmpty){
                actorPresenter.searchURL(searchtext: searchText)
                actorPresenter.searchFunction()
                searchFlag = true
            }
        }
    }


    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        reloadAll()
        actorsTableview.reloadData()
        searchFlag = false
    }
}

