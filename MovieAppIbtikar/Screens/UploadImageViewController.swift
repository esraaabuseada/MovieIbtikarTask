//
//  UploadImageViewController.swift
//  MovieAppIbtikar
//
//  Created by user on 10/14/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit
import OAuthSwift
import SWXMLHash

class UploadImageViewController: UIViewController  {

    @IBOutlet weak var image: UIImageView!
    var imagePicker = UIImagePickerController()
    var data = Data()
   var  oauthswift = OAuth1Swift(
    consumerKey:    "54b9f5f446f8a31c534f6c9a0a17b8e5",
    consumerSecret: "01004de893b671eb",
    requestTokenUrl: "https://www.flickr.com/services/oauth/request_token",
    authorizeUrl:    "https://www.flickr.com/services/oauth/authorize",
    accessTokenUrl:  "https://www.flickr.com/services/oauth/access_token"
    )
    // authorize
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        

      
     
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        _ = self.oauthswift.authorize(
        withCallbackURL: URL(string: "oauth-swift://oauth-callback/flickr")!) { result in
            switch result {
            case .success(let (credential, response, parameters)):
                print(credential.oauthToken)
                print(credential.oauthTokenSecret)
                var imgname = "flower"
                guard let imgData = self.image.image?.pngData() else {return}
               
                let mutli =  OAuthSwiftMultipartData(name: "photo", data: imgData, fileName: "filename" , mimeType: "png")
                
                
                self.oauthswift.client.postMultiPartRequest("https://up.flickr.com/services/upload/", method: .POST, parameters: parameters, multiparts: [mutli], completionHandler: {responseResult in
                    switch responseResult{
                        case .success(let response ):
                        print(response)
                        let xml = SWXMLHash.parse(response.data)
                        print(xml)
                        let photoId = xml["rsp"]["photoid"].element!.text
                        print(photoId)
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                        
                    }
                    
                })
                
            // Do your request
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    @IBAction func pickImage(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        
       
            
            
        present(imagePicker,animated: true, completion: nil)
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

extension UploadImageViewController :UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let img = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image.image = img
            
            
        }
        dismiss(animated: true, completion: nil)
        
       
        
    }
}
