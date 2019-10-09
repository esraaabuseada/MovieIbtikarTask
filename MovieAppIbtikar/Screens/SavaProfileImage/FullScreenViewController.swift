//
//  FullScreenViewController.swift
//  MovieAppIbtikar
//
//  Created by Lost Star on 9/1/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController ,SaveImageViewProtocol {
    
    
    
    @IBOutlet var saveImage: UIImageView!
    var profilePassedObj :Profiles = Profiles(file_path: "\n432vxKiMpgdCmOjq7UX6Gatisa.jpg")
     var imageURL="https://image.tmdb.org/t/p/w500/"
     var data :Data=Data()
        var img : UIImage!
    
    var savePresenter : SaveImagePresenter!

    
    @IBAction func SaveImage(_ sender: UIButton) {
        
        let imgSaveData = saveImage.image!.pngData()
        let compresedImage = UIImage(data:imgSaveData!)
        UIImageWriteToSavedPhotosAlbum(compresedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     profilePassedObj = savePresenter.recivedDataFromModel()
        print(profilePassedObj.file_path)
        
      fetchingDataSuccess()
       
    
    }
    
    
    
    func fetchingDataSuccess() {
        imageURL = imageURL + profilePassedObj.file_path!
        savePresenter.getProfileImages(urlImage: imageURL)
        //imgData = savePresenter.getProfileImages(urlImage: imageURL)
        
    
        
        
    }
    
    func getImageDta(imgD: Data) {
        data = imgD
        if data != nil {
       saveImage.image = UIImage(data: data)
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
                    
                    
                   
                    
                })
                
            }
            
        }
        
    }
    
   

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
