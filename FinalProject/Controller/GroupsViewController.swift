//
//  GroupsViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/29/20.
//

import UIKit
import CoreData

class GroupsViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    //MARK: - VARIABLES
    var groupsArray = [Group]()
    var fetchedResultsController: NSFetchedResultsController<Group>?
    lazy var coreDataStack = CoreDataStack(modelName: "FinalProject")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: - FUNCTIONS
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addGroup"{
            //this is bugged
            let destinationVC = segue.destination as! AddGroupViewController
            //passes our datastack
            destinationVC.coreDataStack = coreDataStack
        }
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchUsers()
        
        self.tableView.reloadData()
    }
    
    func fetchUsers() {
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
            print("Problem fetching users \(error) : \(error.localizedDescription)")
        }
    }
}

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        //find our group
        guard let currentGroup = fetchedResultsController?.object(at: indexPath) else {
            fatalError("Could not fetch the group")
        }
        //populate the cell
        cell.textLabel?.text = currentGroup.group_name
        cell.detailTextLabel?.text = "\(currentGroup.desc)"
        
        return cell
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
