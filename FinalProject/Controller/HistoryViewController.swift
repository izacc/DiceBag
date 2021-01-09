//
//  HistoryViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/29/20.
//

import UIKit
import CoreData

class HistoryViewController: UITableViewController {
    //MARK: - VARIABLES
    public static var coreDataStack = CoreDataStack(modelName: "FinalProject")
    public var coreDataStack2 = CoreDataStack(modelName: "FinalProject")
    public var historyObjects = [History]()
    public var currentGroupName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        do{
            let fetchedResults = try HistoryViewController.coreDataStack.managedContext.fetch(fetchRequest)
            
            if fetchedResults.count >= 1{
               HistoryFetch()
            }else{
                currentGroupName = ""
                historyObjects = []
            }
        }catch{
            print(error)
        }
            
        self.tableView.reloadData()
    }
    
    
    
   


    //MARK: - FUNCTIONS
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch(segue.identifier){
        case "rollTab":
            //segue to add group
            let destinationVC = segue.destination as! RollViewController
            //passes our datastack
            destinationVC.coreDataStack = self.coreDataStack
            break
        case "groupTab":
            //segue to add group
            let destinationVC = segue.destination as! GroupsViewController
            //passes our datastack
            destinationVC.coreDataStack = coreDataStack
            break
        default:
            break
        }
        
    }*/
    
    
    public func HistoryFetch(){
        let fetchRequest: NSFetchRequest<Selected> = Selected.fetchRequest()
        do{
            var currentGroup = Group(context: coreDataStack2.managedContext)
            //fills out object with required info
            currentGroup.group_name = "yessir"
            currentGroup.desc = "groupDescription.text"
            
            //creates a selected property, automatically set to false
            currentGroup.selected = Selected(context: coreDataStack2.managedContext)
            
            //fetches results with coredata
            let fetchedResults = try HistoryViewController.coreDataStack.managedContext.fetch(fetchRequest)
            
            for results in fetchedResults{
                
                //we only want the selected object
                if results.currently_selected{
                    
                    //assign our variable to the text of the group name
                    currentGroup = results.group
                    currentGroupName = currentGroup.group_name
                }
            }
        
            let historyFetchRequest: NSFetchRequest<History> = History.fetchRequest()
            //searches for group matching our currently selected group name
            historyFetchRequest.predicate = NSPredicate(format: "group == %@", currentGroup)
            do{
                let historyFetchedResults = try HistoryViewController.coreDataStack.managedContext.fetch(historyFetchRequest)
                
                
                historyObjects = historyFetchedResults
            }catch{
                print(error)
            }

        
        }catch{
            print(error)
        }

    }

}
//MARK: - EXTENSIONS
extension HistoryViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyObjects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)
        //pull information into our table
        cell.textLabel?.text = "\(historyObjects[indexPath.row].playerName):"
        cell.detailTextLabel?.text = historyObjects[indexPath.row].rollHistory
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //group name header
        return "Group - \(currentGroupName)"
    }
}
