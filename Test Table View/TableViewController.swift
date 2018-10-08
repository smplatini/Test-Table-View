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
        
    
        myTableView.allowsSelectionDuringEditing = true
        
        //To add an edit button in Navigation bar
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        //storing data into array
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
    
    
    //Mark: - Protocol function numberOfSection
    func numberOfSections(in tableView: UITableView) -> Int {
        
           // print(allItem.count)
        return allItem.count
    
    }

    //Mark: - Protocol function numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return allItem[section].count
        
        //add one row if it is in editing mode
        let addedRow = isEditing ? 1 : 0
        return allItem[section].count + addedRow
  
    }
    
    
    //Function used for creating sections with titles
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
    
    //Mark: - Protocol function cellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //check if it is in editing mode
        if indexPath.row >= allItem[indexPath.section].count && isEditing{
            cell.textLabel?.text = "Add New Item"
            cell.detailTextLabel?.text = nil
            cell.imageView?.image = nil
        }
        else{
        
        let item = allItem[indexPath.section][indexPath.row]
        cell.textLabel?.text = item.title
        cell.detailTextLabel?.text = item.subtitle
        
        if let imageView = cell.imageView, let itemImage = item.image {
            imageView.image = itemImage
            
        } else {
            cell.imageView?.image = nil
            
        }
        
        }
        
        return cell
    }
    
    //selecting rows
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        let sectionItems = allItem[indexPath.section]
        if isEditing && indexPath.row < sectionItems.count {
            
            //print("This is  section no. \(indexPath.section)")
            return nil
        }
        
        return indexPath
    }
    
    //function to add delete or insert icons
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        var itemName = UITextField()
        var itemDescription = UITextField()
        
        if editingStyle == .delete {
            
            allItem[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        else if editingStyle == .insert {
            
          /* Added code here */
            
            let alert = UIAlertController(title: "Add a new Item ", message: "", preferredStyle: .alert)
            
            
            //UI alert action closure
            /* ***** what will happen once the user clicks the Add Item button on our UIAlert *********  */
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
                
                if let title = itemName.text{
                    
                    if let subtitle = itemDescription.text {
                        
                        let newItem = DataItem(title: title, subtitle: subtitle, imageName: nil)
                    
                             self.allItem[indexPath.section].append(newItem)
                            self.myTableView.insertRows(at: [indexPath], with: .fade)
                    }
                    
                }
               
               
                
                
            }
            
            //Adding text field to alert UI
            alert.addTextField { (alertTextField) in
                
                alertTextField.placeholder = "Create new item"
               //Create a pointer to alertTextField
                itemName = alertTextField
                
               
                }
            
            alert.addTextField { (alertTextField) in
                
                alertTextField.placeholder = "Add Description"
                itemDescription = alertTextField
                
            }
            
            //Present alert
            alert.addAction(action)
            
            present(alert, animated : true, completion: nil)
                
            }
            
        
            
            
          /*  code ends here*/
            
            
            //let newData = DataItem(title: "New Data", subtitle: "", imageName: nil)
           // allItem[indexPath.section].append(newData)
           // myTableView.insertRows(at: [indexPath], with: .fade)
            
        }
        
    
    
    //Function to enable editing and adding items
    override func setEditing(_ editing: Bool, animated: Bool) {
      super.setEditing(editing, animated: animated)
        
        if editing{
            
            myTableView.beginUpdates()
            
            for (index, sectionItems) in allItem.enumerated(){
            
                let indexPath = IndexPath(row: sectionItems.count, section: index)
                myTableView.insertRows(at: [indexPath], with: .fade)
                
            }
            
            myTableView.endUpdates()
            
            myTableView.setEditing(true, animated: true)
            
        }
        else{
            
           myTableView.beginUpdates()
            
            for (index, sectionItems) in allItem.enumerated(){
                
                let indexPath = IndexPath(row: sectionItems.count, section: index)
                
                myTableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            
            myTableView.endUpdates()
            myTableView.setEditing(false, animated: true)
            
        }
        
        
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        let sectionItems = allItem[indexPath.section]
        
        if indexPath.row == sectionItems.count {
            return .insert
        } else {
            return .delete
        }
    }
    
    /* *************************************************************************************************************************************** */
    
    //Mark - Enable movement of rows
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        
        let sectionItems = allItem[indexPath.section]
        
        if indexPath.row >= sectionItems.count && isEditing {
            
            return false
            
        }
        
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let itemToMove = allItem[sourceIndexPath.section][sourceIndexPath.row]
        
        allItem[sourceIndexPath.section].remove(at: sourceIndexPath.row)
        
        if sourceIndexPath.section == destinationIndexPath.section {
            
            allItem[sourceIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
            
            
        }
        else{
            
            allItem[destinationIndexPath.section].insert(itemToMove, at: destinationIndexPath.row)
            
        }
    }
  
    // Make sure the item is added within the array and not outside the Array

    func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        
        let sectionItems = allItem[proposedDestinationIndexPath.section]
        
        if proposedDestinationIndexPath.row >= sectionItems.count {
            
            return IndexPath(row: sectionItems.count - 1, section: proposedDestinationIndexPath.section)
            
        }
        
        return proposedDestinationIndexPath
        
    }
    
    
}



