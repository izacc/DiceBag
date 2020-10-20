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
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "group_name", ascending: true)]
        
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: coreDataStack.managedContext, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController?.delegate = self
        
        do{
//            users = try coreDataStack.managedContext.fetch(fetchRequest)
            try fetchedResultsController?.performFetch()
            
        } catch {
            print("Problem fetching users \(error) : \(error.localizedDescription)")
        }
    }
}
