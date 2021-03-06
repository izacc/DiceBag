//
//  AddGroupViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/20/20.
//

import UIKit
import CoreData

class AddGroupViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupDescription: UITextView!
    @IBOutlet weak var addPlayerButton: UIButton!
    var playerName: String = ""
    
    //MARK: - CONSTRAINTS
    
  

    @IBOutlet var addButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet var playerNameTopConstraint: NSLayoutConstraint!
    //MARK: - VARIABLES
    var coreDataStack: CoreDataStack!
    var didCreatePlayer1: Bool = false
    var lastPlayerTextField: UITextField!
    var playerNames: [UITextField] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //makes our plus button round
        addPlayerButton.layer.cornerRadius = addPlayerButton.frame.height * 0.50
        addPlayerButton.clipsToBounds = true
        
        self.groupName.delegate = self
        self.groupDescription.delegate = self
        
    }
    
    //MARK: - ACTIONS
    
    //FailSafes for form completetion
    
    
    //checks to see the player textfield has text before adding a player
    @IBAction func AddPlayer(_ sender: Any) {
        if playerNames.count >= 6{
            let ac = UIAlertController(title: "Max players for group is 6", message: nil, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(ac, animated: true, completion: nil)
        }else{
            let ac = UIAlertController(title: "Please input player name", message: nil, preferredStyle: .alert)
            ac.addTextField(configurationHandler: {(textField) in
                textField.placeholder = "Player Name"
                textField.autocapitalizationType = .words
            })
            ac.addAction(UIAlertAction(title: "Add", style: .default, handler: {(_) in
                self.playerName = ac.textFields![0].text!
                
                if(self.playerName == ""){
                    let ac = UIAlertController(title: "Player Field Empty!", message: "Please input a player name", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(ac, animated: true)
                }else{
                    self.GenerateTextField()
                }
            }))
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            present(ac, animated: true, completion: nil)
        
        
        
    }
    }
    
    //checks the rest of the fields have information before moving on
    @IBAction func AddGroup(_ sender: Any) {
        //checks for name field
        guard let group_name = groupName.text, !group_name.isEmpty else {
            let ac = UIAlertController(title: "No Group Name!", message: "Your group must have a name", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
            
            
        }
        //checks for description field
        guard let group_desc = groupDescription.text, !group_desc.isEmpty else {
            let ac = UIAlertController(title: "No Group Description!", message: "Your group must have a description", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
        }
        
        //checks if players have been added
        if playerNames.count == 0 {
            let ac = UIAlertController(title: "No Players!", message: "Please add players", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
        }
        
        //create a new object and insert into the context
        let newGroup = Group(context: coreDataStack.managedContext)
        //fills out object with required info
        newGroup.group_name = group_name
        newGroup.desc = groupDescription.text!
        //Adds players to our object from the generated textfields
        PlayerCreator(textFields: playerNames, group: newGroup)
        
        //creates a selected property, automatically set to false
        newGroup.selected = Selected(context: coreDataStack.managedContext)
        
        //save the context (with the new Group)
        coreDataStack.saveContext()
        
        
        //dismiss this viewcontroller
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - FUNCTIONS
    //this function is how we get our players names to pop-up after we input them
    func GenerateTextField(){
        if !didCreatePlayer1 {
            let newTextField: UITextField = UITextField(frame: CGRect(x: 20.0, y: 468.0, width: 394, height: 34))
            
            
            
            //add attributes here
            newTextField.borderStyle = .roundedRect
            newTextField.backgroundColor = .white
            newTextField.text = playerName
            newTextField.autocapitalizationType = .words
            newTextField.isEnabled = false
        
            //assigns to variable so we know the position of the text field
            lastPlayerTextField = newTextField
            //adds to the view
            self.view.addSubview(lastPlayerTextField)
            playerNames.append(lastPlayerTextField)
            
            playerName = ""
            //changes add button top constraint
            
            let newButtonConstraint = NSLayoutConstraint(item: addButtonTopConstraint.firstItem!, attribute: addButtonTopConstraint.firstAttribute, relatedBy: addButtonTopConstraint.relation, toItem: lastPlayerTextField, attribute: addButtonTopConstraint.secondAttribute, multiplier: addButtonTopConstraint.multiplier, constant: addButtonTopConstraint.constant)
            
            //changes playertextfield top constraint
            let newPlayerNameConstraint = NSLayoutConstraint(item: playerNameTopConstraint.firstItem!, attribute: playerNameTopConstraint.firstAttribute, relatedBy: playerNameTopConstraint.relation, toItem: lastPlayerTextField, attribute: playerNameTopConstraint.secondAttribute, multiplier: playerNameTopConstraint.multiplier, constant: playerNameTopConstraint.constant)
            
            //deactivates constraints
            NSLayoutConstraint.deactivate([ addButtonTopConstraint, playerNameTopConstraint])
             
            //reassigns constraints
             addButtonTopConstraint = newButtonConstraint
             playerNameTopConstraint = newPlayerNameConstraint
             
            //activates them again
             NSLayoutConstraint.activate([ addButtonTopConstraint, playerNameTopConstraint])
            
            //animates
            UIView.animate(withDuration: 0.3, animations: {
               
                
                self.view.layoutIfNeeded()
                
            })
            
            didCreatePlayer1 = true
            
        }else{
            let newTextField: UITextField = UITextField(frame: CGRect(x: lastPlayerTextField.frame.origin.x, y: lastPlayerTextField.frame.origin.y + 35, width: lastPlayerTextField.frame.width, height: lastPlayerTextField.frame.height))
            
            //add attributes here
            newTextField.borderStyle = .roundedRect
            newTextField.backgroundColor = .white
            newTextField.text = playerName
            newTextField.isEnabled = false
        
            //assigns to variable so we know the position of the text field
            lastPlayerTextField = newTextField
            //adds to the view
            self.view.addSubview(lastPlayerTextField)
            playerNames.append(lastPlayerTextField)
            playerName = ""
            
            //changes add button top constraint
            
            let newButtonConstraint = NSLayoutConstraint(item: addButtonTopConstraint.firstItem!, attribute: addButtonTopConstraint.firstAttribute, relatedBy: addButtonTopConstraint.relation, toItem: lastPlayerTextField, attribute: addButtonTopConstraint.secondAttribute, multiplier: addButtonTopConstraint.multiplier, constant: addButtonTopConstraint.constant)
            
            //changes playertextfield top constraint
            let newPlayerNameConstraint = NSLayoutConstraint(item: playerNameTopConstraint.firstItem!, attribute: playerNameTopConstraint.firstAttribute, relatedBy: playerNameTopConstraint.relation, toItem: lastPlayerTextField, attribute: playerNameTopConstraint.secondAttribute, multiplier: playerNameTopConstraint.multiplier, constant: playerNameTopConstraint.constant)
            
            
        //deactivates current constraints
           NSLayoutConstraint.deactivate([ addButtonTopConstraint, playerNameTopConstraint])
            //reassigns values on constraints
            addButtonTopConstraint = newButtonConstraint
            playerNameTopConstraint = newPlayerNameConstraint
            //activates constraints
            NSLayoutConstraint.activate([ addButtonTopConstraint, playerNameTopConstraint])
            
            //animates
            UIView.animate(withDuration: 0.3, animations: {
               
                
                self.view.layoutIfNeeded()
                
            })
        }
        
        
    }
    

    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        // Try to find next responder
        let nextResponder = textField.superview?.viewWithTag(nextTag) as UIResponder?

        if nextResponder != nil {
            // Found next responder, so set it
            nextResponder?.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard
            textField.resignFirstResponder()
        }

        return false
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        //if enter is pressed, resign first responder(keyboard)
        if (text == "\n"){
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    func PlayerCreator(textFields: [UITextField], group: Group){
        //loops through our creates textfields
        for textField in textFields {
            //creates a player object
            let player = Player(context: coreDataStack.managedContext)
            //sets the player name to the text from our textfield
            player.name = textField.text!
            //adds it to our group object
            group.addToPlayer(player)
        }
    }
    


}
