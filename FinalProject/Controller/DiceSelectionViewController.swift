//
//  DiceSelectionViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/29/20.
//

import UIKit


class DiceSelectionViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var RollButton: UIButton!
    @IBOutlet weak var d4Dice: UIButton!
    @IBOutlet weak var d6Dice: UIButton!
    @IBOutlet weak var d8Dice: UIButton!
    @IBOutlet weak var d10Dice: UIButton!
    @IBOutlet weak var d12Dice: UIButton!
    @IBOutlet weak var d20Dice: UIButton!
    
    @IBOutlet weak var d4Label: UILabel!
    @IBOutlet weak var d6Label: UILabel!
    @IBOutlet weak var d8Label: UILabel!
    @IBOutlet weak var d10Label: UILabel!
    @IBOutlet weak var d12Label: UILabel!
    @IBOutlet weak var d20Label: UILabel!
    
    //MARK: - Variables
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        d4Label.alpha = 0;
        d6Label.alpha = 0;
        d8Label.alpha = 0;
        d10Label.alpha = 0;
        d12Label.alpha = 0;
        d20Label.alpha = 0;
        DiceBag.DiceBag = []
        
        
        
        d4Dice.addGestureRecognizer(createLongPress())
        d6Dice.addGestureRecognizer(createLongPress())
        d8Dice.addGestureRecognizer(createLongPress())
        d10Dice.addGestureRecognizer(createLongPress())
        d12Dice.addGestureRecognizer(createLongPress())
        d20Dice.addGestureRecognizer(createLongPress())
        

    }
    
    
    
    
    //MARK: - Button Actions
    @IBAction func rollButtonTapped(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func d4DicePressed(_ sender: Any) {
        //ensures the user can only roll 6 or less dice at one time
        if DiceBag.DiceBag.count < 6 {
            //Adds a d4 dice to our dicebag(inventory)
            DiceBag.DiceBag.append(DiceBag.diceD4)
            //updates inventory tracker of dicebag
            DiceInventory()
        }
    }
    
    @IBAction func d6DicePressed(_ sender: Any) {
        //ensures the user can only roll 6 or less dice at one time
        if DiceBag.DiceBag.count < 6 {
            //Adds a d6 dice to our dicebag(inventory)
            DiceBag.DiceBag.append(DiceBag.diceD6)
            //updates inventory tracker of dicebag
            DiceInventory()
        }
    }
    
    @IBAction func d8DicePressed(_ sender: Any) {
        //ensures the user can only roll 6 or less dice at one time
        if DiceBag.DiceBag.count < 6 {
            //Adds a d8 dice to our dicebag(inventory)
            DiceBag.DiceBag.append(DiceBag.diceD8)
            //updates inventory tracker of dicebag
            DiceInventory()
        }
    }
    
    @IBAction func d10DicePressed(_ sender: Any) {
        //ensures the user can only roll 6 or less dice at one time
        if DiceBag.DiceBag.count < 6 {
            //Adds a d10 dice to our dicebag(inventory)
            DiceBag.DiceBag.append(DiceBag.diceD10)
            //updates inventory tracker of dicebag
            DiceInventory()
        }
    }
    
    @IBAction func d12DicePressed(_ sender: Any) {
        //ensures the user can only roll 6 or less dice at one time
        if DiceBag.DiceBag.count < 6 {
            //Adds a d12 dice to our dicebag(inventory)
            DiceBag.DiceBag.append(DiceBag.diceD12)
            //updates inventory tracker of dicebag
            DiceInventory()
        }
    }
    
    @IBAction func d20DicePressed(_ sender: Any) {
        //ensures the user can only roll 6 or less dice at one time
        if DiceBag.DiceBag.count < 6 {
            //Adds a d20 dice to our dicebag(inventory)
            DiceBag.DiceBag.append(DiceBag.diceD20)
            //updates inventory tracker of dicebag
            DiceInventory()
        }
    }
    //clears our dicebag, makes dice text dissappear and shakes our dice
    @IBAction func ClearDiceBag(_ sender: Any) {
        DiceBag.DiceBag = []
        d4Label.alpha = 0;
        d6Label.alpha = 0;
        d8Label.alpha = 0;
        d10Label.alpha = 0;
        d12Label.alpha = 0;
        d20Label.alpha = 0;
        Animations.shake(on: d4Dice)
        Animations.shake(on: d6Dice)
        Animations.shake(on: d8Dice)
        Animations.shake(on: d10Dice)
        Animations.shake(on: d12Dice)
        Animations.shake(on: d20Dice)
        
        
    }
    
    
    
    //MARK: - Functions
    //creates a long press gesture for attached item
    func createLongPress() -> UILongPressGestureRecognizer {
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(removeDice))
        longPress.minimumPressDuration = 1
        return longPress
    }
    
    //updates our text next to the buttons for quantity
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
                d4Label.alpha = 1;
                break
            case 6:
                d6Quantity += 1
                d6Label.alpha = 1;
                break
            case 8:
                d8Quantity += 1
                d8Label.alpha = 1;
                break
            case 10:
                d10Quantity += 1
                d10Label.alpha = 1;
                break
            case 12:
                d12Quantity += 1
                d12Label.alpha = 1;
                break
            case 20:
                d20Quantity += 1
                d20Label.alpha = 1;
                break
            default:
                break
            }
        }
        
        
        d4Label.text = "x\(d4Quantity)"
        d6Label.text = "x\(d6Quantity)"
        d8Label.text = "x\(d8Quantity)"
        d10Label.text = "x\(d10Quantity)"
        d12Label.text = "x\(d12Quantity)"
        d20Label.text = "x\(d20Quantity)"
        
    }
    
    @objc func removeDice(sender: UILongPressGestureRecognizer){
        
        guard let button = sender.view as? UIButton else { return }
        
        //search for specific dice in dicebag and remove it, update visual inventory
        
        if sender.state == .ended{
            //checks the label of the button being pressed
            switch(button.title(for: .normal)){
            case "d4Dice":
                //creates index for firstelement of type diceD4
                if let index = DiceBag.DiceBag.firstIndex(of: DiceBag.diceD4){
                    //shakes dice when long pressed
                    Animations.shake(on: button)
                    //removes it from the index
                    DiceBag.DiceBag.remove(at: index)
                    //checks if the dice bag no longer has any types of that dice
                    if !DiceBag.DiceBag.contains(DiceBag.diceD4){
                        //sets alpha of label to 0
                        d4Label.alpha = 0
                    }
                }
                break
            case "d6Dice":
                if let index = DiceBag.DiceBag.firstIndex(of: DiceBag.diceD6){
                    //shakes dice when long pressed
                    Animations.shake(on: button)
                    DiceBag.DiceBag.remove(at: index)
                    if !DiceBag.DiceBag.contains(DiceBag.diceD6){
                        d6Label.alpha = 0
                    }
                }
                break
            case "d8Dice":
                if let index = DiceBag.DiceBag.firstIndex(of: DiceBag.diceD8){
                    //shakes dice when long pressed
                    Animations.shake(on: button)
                    
                    DiceBag.DiceBag.remove(at: index)
                    if !DiceBag.DiceBag.contains(DiceBag.diceD8){
                        d8Label.alpha = 0
                    }
                }
                break
            case "d10Dice":
                if let index = DiceBag.DiceBag.firstIndex(of: DiceBag.diceD10){
                    //shakes dice when long pressed
                    Animations.shake(on: button)
                    DiceBag.DiceBag.remove(at: index)
                    if !DiceBag.DiceBag.contains(DiceBag.diceD10){
                        d10Label.alpha = 0
                    }
                }
                break
            case "d12Dice":
                if let index = DiceBag.DiceBag.firstIndex(of: DiceBag.diceD12){
                    //shakes dice when long pressed
                    Animations.shake(on: button)
                    DiceBag.DiceBag.remove(at: index)
                    if !DiceBag.DiceBag.contains(DiceBag.diceD12){
                        d12Label.alpha = 0
                    }
                }
                break
            case "d20Dice":
                if let index = DiceBag.DiceBag.firstIndex(of: DiceBag.diceD20){
                    //shakes dice when long pressed
                    Animations.shake(on: button)
                    DiceBag.DiceBag.remove(at: index)
                    if !DiceBag.DiceBag.contains(DiceBag.diceD20){
                        d20Label.alpha = 0
                    }
                }
                break


            default:
                break
            }
            DiceInventory()
        }
        
    }
    
    
    
}
