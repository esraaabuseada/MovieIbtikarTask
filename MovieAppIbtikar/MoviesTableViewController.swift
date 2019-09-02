//
//  MoviesTableViewController.swift
//  MovieAppIbtikar
//
//  Created by Lost Star on 8/30/19.
//  Copyright © 2019 esraa mohamed. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {
    var personName:String=""
    var personKnownForDepartment:String=""
    var personProfilePath:String=""
    var personId = Int()
    var personImage:UIImageView!
    var personNameLabel:UILabel!
    var personKnowLabel:UILabel!
    var persons:[Person]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        parseJSON()
    }

    @IBAction func refresh(_ sender: UIRefreshControl) {
        persons.removeAll()
        parseJSON()
        sender.endRefreshing()
        tableView.reloadData()
        
    }
    // MARK: - Table view data source
    
    func updateData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    
    func parseJSON() {
        let url = URL(string:"https://api.themoviedb.org/3/person/popular?api_key=cb8effcf3a0b27a05a7daba0064a32e1")
        
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
            let personsArray = json["results"] as? [Dictionary<String,Any>] ?? []
                //print(personsArray)
                self.persons.removeAll()
               
                
                for p in personsArray{
                     var personObj=Person()
                     self.personName=p["name"] as? String ?? ""
                    self.personKnownForDepartment=p["known_for_department"] as? String ?? ""
                    self.personProfilePath=p["profile_path"] as? String ?? ""
                    self.personId=p["id"] as? Int ?? 0
                    
                    personObj.name=self.personName
                    personObj.known_for_department=self.personKnownForDepartment
                    personObj.profile_path=self.personProfilePath
                    personObj.id=self.personId
                    self.persons.append(personObj)
           
                   
                    

                    
                    
                }
                
                self.updateData()
                
                
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
                        imageView.alpha = 0
                        
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return persons.count
    }

  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)

        // Configure the cell...
        personImage = cell.viewWithTag(1) as? UIImageView
        personNameLabel=cell.viewWithTag(2) as? UILabel
        personKnowLabel=cell.viewWithTag(3) as? UILabel
        
        personNameLabel.text=persons[indexPath.row].name
        personKnowLabel.text=persons[indexPath.row].known_for_department
        var url:String=""
        url="https://image.tmdb.org/t/p/w500/"
        var imageUrl:String=""
         imageUrl=url + persons[indexPath.row].profile_path
        
        
        get_image(imageUrl,personImage)
       
        if(indexPath.row==persons.count-1){
            parseJSON()
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myVC = storyboard?.instantiateViewController(withIdentifier: "dvc") as! DetailsViewController
        myVC.stringPassed = persons[indexPath.row].name
        myVC.theImagePassed =  persons[indexPath.row].profile_path
        myVC.idPassed = persons[indexPath.row].id
        navigationController?.pushViewController(myVC, animated: true)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
