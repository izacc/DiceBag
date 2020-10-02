//
//  DiceSelectionViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/29/20.
//

import UIKit


class DiceSelectionViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var d4Dice: UIButton!
    @IBOutlet weak var d6Dice: UIButton!
    @IBOutlet weak var d8Dice: UIButton!
    @IBOutlet weak var d10Dice: UIButton!
    @IBOutlet weak var d12Dice: UIButton!
    @IBOutlet weak var d20Dice: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: - Button Actions
    @IBAction func d4DicePressed(_ sender: Any) {
        //Adds a d4 dice to our dicebag(inventory)
        DiceBag.DiceBag.append(DiceBag.diceD4)
        //updates inventory tracker of dicebag
        DiceInventory()
    }
    
    @IBAction func d6DicePressed(_ sender: Any) {
        //Adds a d6 dice to our dicebag(inventory)
        DiceBag.DiceBag.append(DiceBag.diceD6)
        //updates inventory tracker of dicebag
        DiceInventory()
    }
    
    @IBAction func d8DicePressed(_ sender: Any) {
        //Adds a d8 dice to our dicebag(inventory)
        DiceBag.DiceBag.append(DiceBag.diceD8)
        //updates inventory tracker of dicebag
        DiceInventory()
    }
    
    @IBAction func d10DicePressed(_ sender: Any) {
        //Adds a d10 dice to our dicebag(inventory)
        DiceBag.DiceBag.append(DiceBag.diceD10)
        //updates inventory tracker of dicebag
        DiceInventory()
    }
    
    @IBAction func d12DicePressed(_ sender: Any) {
        //Adds a d12 dice to our dicebag(inventory)
        DiceBag.DiceBag.append(DiceBag.diceD12)
        //updates inventory tracker of dicebag
        DiceInventory()
    }
    
    @IBAction func d20DicePressed(_ sender: Any) {
        //Adds a d20 dice to our dicebag(inventory)
        DiceBag.DiceBag.append(DiceBag.diceD20)
        //updates inventory tracker of dicebag
        DiceInventory()
    }
    
    
    
    
    //MARK: - Functions
    func DiceInventory(){
        var d4Quantity = 0
        var d6Quantity = 0
        var d8Quantity = 0
        var d10Quantity = 0
        var d12Quantity = 0
        var d20Quantity = 0
        for die in DiceBag.DiceBag{
            switch(die.sides){
            case 4:
                d4Quantity += 1
                break
            case 6:
                d6Quantity += 1
                break
            case 8:
                d8Quantity += 1
                break
            case 10:
                d10Quantity += 1
                break
            case 12:
                d12Quantity += 1
                break
            case 20:
                d20Quantity += 1
                break
            default:
                break
            }
        }
        
    }
}
