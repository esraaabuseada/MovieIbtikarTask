//
//  DetailsViewController.swift
//  MovieAppIbtikar
//
//  Created by Lost Star on 9/1/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,DetailsViewProtocol, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet var collectionview: UICollectionView!
    var  imageURL="https://image.tmdb.org/t/p/w500/"
    var personObjPassed = Person(id: 18918,profile_path: "/kuqFzlYMc2IrsOyPznMd1FroeGq.jpg",name: "Dwayne Johnson")
    var passedImage : UIImage!
    var profilesArray:[Profiles]=[]
    var pageNumber:Int=1
    let actorModelObj = ActorModel()
    var imgData :Data=Data()
    var urlString = ""
    var file_path:String=""
      var detailsPresenter :DetailsPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.dataSource=self as! UICollectionViewDataSource
        self.collectionview.delegate=self as! UICollectionViewDataSource as! UICollectionViewDelegate
        
        personObjPassed = (detailsPresenter!.recivedDataFromModel())
       print(personObjPassed.id)
        var id = "\(personObjPassed.id)"
        detailsPresenter?.viewDidLoad(id: id)
        
        guard  detailsPresenter.ProfilesArrayMethod() != nil else {
            print("no profilessss")
            return
        }
       
    }
    
    func updateData(){
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
        
    }
    
    func  getImage(actorImageView:UIImageView,imageData:Data ) {
        if imageData != nil
        {
            let image = UIImage(data: imageData)
            
            
            if(image != nil)
            {
                
                DispatchQueue.main.async(execute: {
                    
                    actorImageView.image = image
                    actorImageView.alpha = 0
                    
                    
                    UIView.animate(withDuration: 0, animations: {
                        actorImageView.alpha = 1.0
                    })
                    
                })
                
            }
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return (detailsPresenter!.getProfilesCount())
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        
        

        
     
        profilesArray = detailsPresenter.ProfilesArrayMethod()
        print("detaaaiiilss profiles" + "\(profilesArray)")
            var p = profilesArray[indexPath.row]
            var urlImageString = imageURL + p.file_path
        var data = detailsPresenter!.getProfileImages(urlImage: urlImageString)
                print(urlImageString)
        detailsPresenter?.configureCell(cell: cell, for: indexPath.row, profiles: p, imgData: data)
        //        actorPresenter.configure(cell: cell!, for: indexPath.row, person: p, imgData: data)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderVIew", for: indexPath) as! HeaderVIew
        detailsPresenter?.configureHeader(header: header, for: indexPath.row)
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       detailsPresenter.didSelectRow(index: indexPath.row)
    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    func reloadAll() {
    }
    
    func navigateToUserDetailsScreen(profiles: Profiles) {
        let saveImageviewController = self.storyboard?.instantiateViewController(withIdentifier: "fulVC")
            as! FullScreenViewController
        saveImageviewController.savePresenter = SaveImagePresenter(viewProtocol: saveImageviewController, modelProtocol: SaveImageModel(profileObj: profiles))
        navigationController?.pushViewController(saveImageviewController, animated: true)
    }
    
    
    
    
}
