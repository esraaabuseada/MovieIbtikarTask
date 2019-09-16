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
    var personObjPassed = Person()
    var passedImage : UIImage!
    var profilesArray:[Profiles]=[]
    var pageNumber:Int=1
    let actorModelObj = ActorModel()
    var imgData :Data=Data()
    var urlString = ""
    var file_path:String=""
      var detailsPresenter :DetailsPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.dataSource=self as! UICollectionViewDataSource
        self.collectionview.delegate=self as! UICollectionViewDataSource as! UICollectionViewDelegate
        
        detailsPresenter?.viewDidLoad()
        
      
        personObjPassed = (detailsPresenter?.recivedDataFromModel())!
       print(personObjPassed.name)
        
        
        print(profilesArray)
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
        return (detailsPresenter?.getProfilesCount())!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        
        let urlProfiles = imageURL + profilesArray[indexPath.row].file_path
//        detailsModelObj.requestImageURLProfile(url: urlProfiles, completion:{dataResult , imageResult in
//            self.imgData = dataResult
//            cell.collectionImage = imageResult
//
//        })
        self.getImage(actorImageView: cell.collectionImage,imageData:self.imgData  )
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderVIew", for: indexPath) as! HeaderVIew
        
        detailsPresenter?.configure(header: header, for: indexPath.row)
        
        
//        var imgString = imageURL + personObjPassed.profile_path
//        print("person" + imgString)
//        actorModelObj.requestImageURL(url:imgString,imageD: header.headerImage, completion:{dataResult , imageResult in
//            self.imgData = dataResult
//            // header.headerImage = imageResult
//
//        })
//        print(self.imgData)
//        getImage(actorImageView: header.headerImage,imageData:self.imgData  )
//
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fulVC = storyboard?.instantiateViewController(withIdentifier: "fulVC") as! FullScreenViewController
        
        let selectedCell = collectionView.cellForItem(at: indexPath) as? CustomCell
        
        fulVC.img = selectedCell?.collectionImage.image
        
        
        navigationController?.pushViewController(fulVC , animated:true)    }
    
    func fetchingDataSuccess() {
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
    }
    
    func reloadAll() {
    }
    
    func navigateToUserDetailsScreen(profiles: Profiles) {
    }
    
}
