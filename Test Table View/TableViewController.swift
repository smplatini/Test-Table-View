//
//  ViewController.swift
//  Test Table View
//
//  Created by Saad Platini on 07.10.18.
//  Copyright © 2018 Saad Platini. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var myTableView: UITableView!
    
    
    var itemAmph = [DataItem]()
    var itemRep = [DataItem]()
    var itemFish = [DataItem]()
    
    var allItem = [[DataItem]]()
    
    var amphibians = ["Salamander":"This is an amphibian","Newt":"This is an amphibian", "Frog":"This is an amphibian","Skink":"This is an amphibian"]
    var reptiles = ["Chameleon":"This is a reptile","Crocodile":"This is a reptile", "Lizard":"This is a reptile","Snake":"This is a reptile","Turtle":"This is a reptile"]
    var fish = ["Bluefin-Tuna":"This is a fish","Catfish":"This is a fish", "Halibut":"This is a fish","Mackerel":"This is a fish","Salmon":"This is a fish"]
    
    
    //"Frog ":"This is an amphibian"
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        for (key,value) in amphibians {
          
            let newItem = DataItem(title: key, subtitle: value, imageName: key)
           itemAmph.append(newItem)
            
            
        }
        
        for (key,value) in reptiles {
            
            let newItem = DataItem(title: key, subtitle: value, imageName: key)
            itemRep.append(newItem)
            
            
        }
       
        
        for (key,value) in fish {
            
            let newItem = DataItem(title: key, subtitle: value, imageName: key)
            itemFish.append(newItem)
            
        
    }
        allItem.append(itemAmph)
        allItem.append(itemRep)
        allItem.append(itemFish)
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
            print(allItem.count)
        return allItem.count
    
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allItem[section].count
    }
    
    //Function used for creating sections
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "Section #\(section)"
        
        if section == 0 {
            return "Amphibians"
        }
        else if section == 1 {
            return "Reptiles"
        }
        else{
            return "Fish"
        }
    }
    
    //function for displaying cells in tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let item = allItem[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        if let imageView = cell.imageView, let itemImage = item.image {
            imageView.image = itemImage
            
        } else {
            cell.imageView?.image = nil
            
        }
        
        
        
        return cell
    }
    
    
    
    

}

