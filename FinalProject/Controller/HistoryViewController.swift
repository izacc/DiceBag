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
    public var coreDataStack = CoreDataStack(modelName: "FinalProject")
    public var historyObjects = [History]()
    override func viewDidLoad() {
        super.viewDidLoad()
            HistoryFetch()
        }
    override func viewWillAppear(_ animated: Bool) {
        HistoryFetch()
    }
    
    
    
   


    //MARK: - FUNCTIONS
    public func HistoryFetch(){
        let fetchRequest: NSFetchRequest<Selected> = Selected.fetchRequest()
        do{
            var currentGroup = Group(context: coreDataStack.managedContext)
            //fills out object with required info
            currentGroup.group_name = "group_name"
            currentGroup.desc = "groupDescription.text!"
            
            //creates a selected property, automatically set to false
            currentGroup.selected = Selected(context: coreDataStack.managedContext)
            
            //fetches results with coredata
            let fetchedResults = try coreDataStack.managedContext.fetch(fetchRequest)
            
            for results in fetchedResults{
                
                //we only want the selected object
                if results.currently_selected{
                    
                    //assign our variable to the text of the group name
                    currentGroup = results.group
                }
            }
        
            let historyFetchRequest: NSFetchRequest<History> = History.fetchRequest()
            //searches for group matching our currently selected group name
            historyFetchRequest.predicate = NSPredicate(format: "group == %@", currentGroup)
            do{
                let historyFetchedResults = try coreDataStack.managedContext.fetch(historyFetchRequest)
                
                
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

        cell.textLabel?.text = "\(historyObjects[indexPath.row].playerName):"
        cell.detailTextLabel?.text = historyObjects[indexPath.row].rollHistory
        return cell
    }
}
