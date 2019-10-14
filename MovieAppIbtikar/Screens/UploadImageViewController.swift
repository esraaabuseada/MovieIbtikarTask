//
//  UploadImageViewController.swift
//  MovieAppIbtikar
//
//  Created by user on 10/14/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class UploadImageViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        

        // Do any additional setup after loading the view.
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
