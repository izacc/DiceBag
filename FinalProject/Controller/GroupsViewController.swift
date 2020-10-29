//
//  GroupsViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/29/20.
//

import UIKit
import CoreData

class GroupsTableViewCell: UITableViewCell{
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellTitle: UILabel!
}

class GroupsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    //MARK: - VARIABLES
    var groupsArray = [Group]()
    var fetchedResultsController: NSFetchedResultsController<Group>?
    lazy var coreDataStack = CoreDataStack(modelName: "FinalProject")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    //MARK: - FUNCTIONS
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup"{
            //segue to add group
            let destinationVC = segue.destination as! AddGroupViewController
            //passes our datastack
            destinationVC.coreDataStack = coreDataStack
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //loads our page with the correct information when we swap between pages
        fetchGroups()
        
        self.tableView.reloadData()
    }
    
    func fetchGroups() {
        //creates new fetch request
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        //alphebetical order by group name
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "group_name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        //trys the fetch request
        do{
            try fetchedResultsController?.performFetch()
            
        } catch {
            print("Problem fetching groups \(error) : \(error.localizedDescription)")
        }
    }
    
    
   
}

//MARK: - EXTENSIONS

extension GroupsViewController{
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch editingStyle{
        //if users swipes for delete
        case.delete:
            //find object
            guard let groupToDelete = fetchedResultsController?.object(at: indexPath) else { return }
            //deletes it
            coreDataStack.managedContext.delete(groupToDelete)
            //saves delete
            coreDataStack.saveContext()
            

        default:
            break
        }
    }
    
}

extension GroupsViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //displays all our information based off of entries in our database
        return fetchedResultsController?.fetchedObjects?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //find our cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as! GroupsTableViewCell
        //find our group
        guard let currentGroup = fetchedResultsController?.object(at: indexPath) else {
            fatalError("Could not fetch the group")
        }
        //populate the cell
        cell.cellTitle.text = currentGroup.group_name
        
        //fretch request of our selected table
        let imageFetchRequest: NSFetchRequest<Selected> = Selected.fetchRequest()
        
        do{
            //fetch with our CoreDataStack
            let fetchedResults = try coreDataStack.managedContext.fetch(imageFetchRequest)
            for results in fetchedResults{
                //if the group id in our CoreData matches the group id of the current cell & it is selected then show image
                if results.group == currentGroup.selected.group && results.currently_selected == true {
                    cell.cellImage.alpha = 1
                //same as above but checks for false to turn off image
                }else if results.group == currentGroup.selected.group && results.currently_selected == false{
                    cell.cellImage.alpha = 0
                }
            }
        }catch{
            
        }
        
        return cell
    }
    
}

extension GroupsViewController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let groupSelected = fetchedResultsController?.object(at: indexPath) else { return }
        
        let fetchRequest: NSFetchRequest<Selected> = Selected.fetchRequest()
        //searches for group id matching selected id
        fetchRequest.predicate = NSPredicate(format: "group == %@", groupSelected.selected.group)
        do{
            let fetchedResults = try coreDataStack.managedContext.fetch(fetchRequest)
            
            //changes selected to true
            fetchedResults.first?.setValue(true, forKey: "currently_selected")
            
            
            //saves to database
            coreDataStack.saveContext()
        }
        catch{
            print(error)
            
        }
        
        let reverseFetchRequest: NSFetchRequest<Selected> = Selected.fetchRequest()
        //searches for all id's not matching selected
        reverseFetchRequest.predicate = NSPredicate(format: "NOT group == %@", groupSelected.selected.group)
        do{
            let fetchedResults = try coreDataStack.managedContext.fetch(reverseFetchRequest)
            
            //sets everything else to false for currently_selected
            for results in fetchedResults{
                results.setValue(false, forKey: "currently_selected")
            }
            //saves
          coreDataStack.saveContext()
        }
        catch{
            print(error)
            
        }
        //reloads our table to show update for image
        fetchGroups()
        self.tableView.reloadData()
    }
}


extension GroupsViewController{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type{
        case .insert:
            guard let insertIndexPath = newIndexPath else { return }
            self.tableView.insertRows(at: [insertIndexPath], with: .automatic)
            
        case .delete:
            guard let deleteIndexPath = indexPath else { return }
            self.tableView.deleteRows(at: [deleteIndexPath], with: .automatic)
            
        case .move:
            guard let fromIndexPath = indexPath, let toIndexPath = newIndexPath else { return }
            self.tableView.moveRow(at: fromIndexPath, to: toIndexPath)
        case .update:
            guard let updateIndexPath = indexPath else { return }
            self.tableView.reloadRows(at: [updateIndexPath], with: .automatic)
        @unknown default:
            fatalError("Unknown case added")
        }
    }
    
}
