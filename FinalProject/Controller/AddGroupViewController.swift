//
//  AddGroupViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/20/20.
//

import UIKit
import CoreData

class AddGroupViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupDescription: UITextView!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playerName: UITextField!
    
    //MARK: - CONSTRAINTS
    
  

    @IBOutlet var addButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet var playerNameTopConstraint: NSLayoutConstraint!
    //MARK: - VARIABLES
    var coreDataStack: CoreDataStack!
    var didCreatePlayer1: Bool = false
    var lastPlayerTextField: UITextField!
    var playerNames: [UITextField] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()        //makes our plus button round
        addPlayerButton.layer.cornerRadius = addPlayerButton.frame.height * 0.50
        addPlayerButton.clipsToBounds = true
        
        self.playerName.delegate = self
        self.groupName.delegate = self
        
        
    }
    
    //MARK: - ACTIONS
    @IBAction func AddPlayer(_ sender: Any) {
        guard let player_name = playerName.text, !player_name.isEmpty else{
            let ac = UIAlertController(title: "Player Field Empty!", message: "Please input a player name", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
        }
        GenerateTextField()
    }
    
    @IBAction func AddGroup(_ sender: Any) {
        guard let group_name = groupName.text, !group_name.isEmpty else {
            let ac = UIAlertController(title: "No Group Name!", message: "Your group must have a name", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
        }
        
        guard let group_desc = groupDescription.text, !group_desc.isEmpty else {
            let ac = UIAlertController(title: "No Group Description!", message: "Your group must have a description", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
        }
        if playerNames.count == 0 {
            let ac = UIAlertController(title: "No Players!", message: "Please add players", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
            
            return
        }
        
        //create a new object and insert into the context
        let newGroup = Group(context: coreDataStack.managedContext)
        newGroup.group_name = group_name
        newGroup.desc = groupDescription.text!
        TextFieldTextGrabber(textFields: playerNames, group: newGroup)
        newGroup.selected = Selected(context: coreDataStack.managedContext)
        newGroup.selected?.selected = false
        
        //save the context (with the new user)
        coreDataStack.saveContext()
        
        
        //dismiss this viewcontroller
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - FUNCTIONS
    
    func GenerateTextField(){
        if !didCreatePlayer1 {
            let newTextField: UITextField = UITextField(frame: CGRect(x: 20.0, y: 453.0, width: 394, height: 34))
            
            
            
            //add attributes here
            newTextField.borderStyle = .roundedRect
            newTextField.backgroundColor = .white
            newTextField.text = playerName.text
            newTextField.isEnabled = false
        
            //assigns to variable so we know the position of the text field
            lastPlayerTextField = newTextField
            //adds to the view
            self.view.addSubview(lastPlayerTextField)
            playerNames.append(lastPlayerTextField)
            
            playerName.text = ""
            //changes add button top constraint
            
            let newButtonConstraint = NSLayoutConstraint(item: addButtonTopConstraint.firstItem!, attribute: addButtonTopConstraint.firstAttribute, relatedBy: addButtonTopConstraint.relation, toItem: lastPlayerTextField, attribute: addButtonTopConstraint.secondAttribute, multiplier: addButtonTopConstraint.multiplier, constant: addButtonTopConstraint.constant)
            
            //changes playertextfield top constraint
            let newPlayerNameConstraint = NSLayoutConstraint(item: playerNameTopConstraint.firstItem!, attribute: playerNameTopConstraint.firstAttribute, relatedBy: playerNameTopConstraint.relation, toItem: lastPlayerTextField, attribute: playerNameTopConstraint.secondAttribute, multiplier: playerNameTopConstraint.multiplier, constant: playerNameTopConstraint.constant)
            
            NSLayoutConstraint.deactivate([ addButtonTopConstraint, playerNameTopConstraint])
             
             addButtonTopConstraint = newButtonConstraint
             playerNameTopConstraint = newPlayerNameConstraint
             
             NSLayoutConstraint.activate([ addButtonTopConstraint, playerNameTopConstraint])
            
            UIView.animate(withDuration: 0.3, animations: {
               
                
                self.view.layoutIfNeeded()
                
            })
            
            didCreatePlayer1 = true
            
        }else{
            let newTextField: UITextField = UITextField(frame: CGRect(x: lastPlayerTextField.frame.origin.x, y: lastPlayerTextField.frame.origin.y + 35, width: lastPlayerTextField.frame.width, height: lastPlayerTextField.frame.height))
            
            //add attributes here
            newTextField.borderStyle = .roundedRect
            newTextField.backgroundColor = .white
            newTextField.text = playerName.text
            newTextField.isEnabled = false
        
            //assigns to variable so we know the position of the text field
            lastPlayerTextField = newTextField
            //adds to the view
            self.view.addSubview(lastPlayerTextField)
            playerNames.append(lastPlayerTextField)
            playerName.text = ""
            
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
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
    
    func TextFieldTextGrabber(textFields: [UITextField], group: Group){
        for textField in textFields {
            let player = Player(context: coreDataStack.managedContext)
            player.name = textField.text!
            group.addToPlayer(player)
        }
    }
    


}
