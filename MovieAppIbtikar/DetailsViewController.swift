//
//  DetailsViewController.swift
//  MovieAppIbtikar
//
//  Created by Lost Star on 9/1/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
   var stringPassed = ""
   var theImagePassed = ""
   var idPassed = Int()
   var personId = Int()
   var file_path:String=""
   @IBOutlet var collectionview: UICollectionView!
   var profiles:[Profiles]=[]
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionview.dataSource=self as! UICollectionViewDataSource
        self.collectionview.delegate=self as! UICollectionViewDataSource as! UICollectionViewDelegate
        
        personId=idPassed
        parseJSON(personId: personId)
    }
    
    func updateData(){
        DispatchQueue.main.async {
            self.collectionview.reloadData()
        }
        
    }
    
    func parseJSON(personId:Int) {
        let str = "\(personId)"
        let imagesUrl="https://api.themoviedb.org/3/person/"+str + "/images?api_key=cb8effcf3a0b27a05a7daba0064a32e1"
        print(imagesUrl)
        let url = URL(string:imagesUrl)
        
        let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            guard error == nil else {
                print("returning error")
                return
            }
            
            guard let content = data else {
                print("not returning data")
                return
            }
            
            
            guard let json = (try? JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers)) as? [String: Any] else {
                print("Not containing JSON")
                return
            }
            
            
            do{
                let profilesArray = json["profiles"] as? [Dictionary<String,Any>] ?? []
                print(profilesArray)
                self.profiles.removeAll()
                
                
                for p in profilesArray{
                    var profileObj=Profiles()
                    self.file_path=p["file_path"] as? String ?? ""
                    profileObj.file_path=self.file_path
                    self.profiles.append(profileObj)
                }
                
                self.updateData()
                
                //self.tableArray = array
            }
            catch{
                print("unable parse jason")
            }
        }
        
        task.resume()
        
    }
    
    
    
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        
                        
                        
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return profiles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 3
        
        var url:String=""
        url="https://image.tmdb.org/t/p/w500/"
        var path:String=""
        path=url + profiles[indexPath.row].file_path
        
        get_image(path,cell.collectionImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionview.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderVIew", for: indexPath) as! HeaderVIew
        header.headerLabel.text=stringPassed
        
        var url:String=""
        url="https://image.tmdb.org/t/p/w500/"
        var imageUrl:String=""
        imageUrl=url + theImagePassed
        
        
        get_image(imageUrl,header.headerImage)
        return header
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fulVC = storyboard?.instantiateViewController(withIdentifier: "fulVC") as! FullScreenViewController
        fulVC.fullImagePassed =  profiles[indexPath.row].file_path
        
        navigationController?.pushViewController(fulVC , animated:true)    }

}
