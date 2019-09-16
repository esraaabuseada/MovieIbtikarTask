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
    
    
    
    
    
    var pageNumber:Int=1
    var totalResults = 0
    var generalURL = "https://api.themoviedb.org/3/person/popular?api_key=cb8effcf3a0b27a05a7daba0064a32e1&page="
    var searchUrl = ""
    var  imageURL="https://image.tmdb.org/t/p/w500/"
    var personsArray:[Person]=[]
    let actorModelObj = ActorModel()
    var imgData :Data=Data()
    var actorImageViw = UIImageView()
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
    
    //Update UI
//    func updateData(){
//        DispatchQueue.main.async {
//            self.actorsTableview.reloadData()
//        }
//    }
    
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
//        actorModelObj.requestImageURL(url: urlImageString, completion:{dataResult  in
//            self.imgData = dataResult
//
//            
//        })
//
//        self.getImage(actorImageView: cell!.actorImage,imageData:self.imgData  )
        
        //Load More
        if(indexPath.row == actorPresenter.getActorsCount()-3 && actorPresenter.getActorsCount() != actorPresenter.totalResults){
            actorPresenter.loadMore()
            

//            if(searchFlag == true){
//                actorModelObj.requestURL(url: searchUrl,pageNo:pageNumber, completion: { _result in
//                    self.personsArray.append(contentsOf: _result)
//                    self.updateData()
//                })
//            }else{
//
//                actorModelObj.requestURL(url: generalURL,pageNo:pageNumber, completion: { _result in
//                    self.personsArray.append(contentsOf: _result)
//                    self.updateData()
//                })
//            }
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! DetailsViewController
        let selectedCell = actorsTableview.cellForRow(at: indexPath) as? ActorTableViewCell
        
        actorPresenter.didSelectRow(index: indexPath.row)
//        myVC.personObjPassed = personsArray[indexPath.row]
//        myVC.passedImage  = selectedCell?.actorImage.image
       // navigationController?.pushViewController(myVC, animated: true)
    }
    
    
    
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.actorsTableview.reloadData()
        }
        
    }
    
    func navigateToUserDetailsScreen(person: Person) {
        navigationController?.pushViewController(UIViewController(), animated: true)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //Search
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        if let searchText = searchBar.text {
//            if(!searchText.isEmpty){
//                self.personsArray = []
//                pageNumber = 1
//                searchUrl = "https://api.themoviedb.org/3/search/person?api_key=3955a9144c79cb1fca10185c95080107&language=en-US&query=\(searchText.replacingOccurrences(of:" ", with:"%20"))&include_adult=false&page="
//                self.actorModelObj.requestURL(url: searchUrl,pageNo:self.pageNumber, completion: { _result in
//                    self.personsArray.append(contentsOf: _result)
//                    print(self.personsArray)
//                    self.updateData()
//                })
//                searchFlag = true
//            }
//        }
//    }
//
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        self.searchBar.showsCancelButton = true
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.showsCancelButton = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//        reloadAll()
//        actorsTableview.reloadData()
//        searchFlag = false
//    }
}

