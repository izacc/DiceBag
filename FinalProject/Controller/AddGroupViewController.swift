//
//  AddGroupViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 10/20/20.
//

import UIKit

class AddGroupViewController: UIViewController, UITextFieldDelegate {
    
    //MARK: - OUTLETS
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var groupDescription: UITextField!
    @IBOutlet weak var addPlayerButton: UIButton!
    @IBOutlet weak var playerName: UITextField!
    
    //MARK: - CONSTRAINTS
    
  

    @IBOutlet var addButtonTopConstraint: NSLayoutConstraint!
    @IBOutlet var playerNameTopConstraint: NSLayoutConstraint!
    //MARK: - VARIABLES
    var coreDataStack: CoreDataStack!
    var didCreatePlayer1: Bool = false
    var lastPlayerTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        groupDescription.borderStyle = .roundedRect
        //makes our plus button round
        addPlayerButton.layer.cornerRadius = addPlayerButton.frame.height * 0.50
        addPlayerButton.clipsToBounds = true
        
        self.playerName.delegate = self
        self.groupDescription.delegate = self
        self.groupName.delegate = self
    }
    
    //MARK: - ACTIONS
    @IBAction func AddPlayer(_ sender: Any) {
        GenerateTextField()
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
        textField.resignFirstResponder()
        return true
    }
    


}
