//
//  ViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/28/20.
//

import UIKit

class RollViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var RollButton: UIButton!
    
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var rollingLabel: UILabel!
    @IBOutlet weak var rollingDice1: UIImageView!
    @IBOutlet weak var rollingDice2: UIImageView!
    @IBOutlet weak var rollingDice3: UIImageView!
    @IBOutlet weak var rollingDice4: UIImageView!
    @IBOutlet weak var rollingDice5: UIImageView!
    @IBOutlet weak var rollingDice6: UIImageView!
    @IBOutlet weak var rollingDice1Label: UILabel!
    @IBOutlet weak var rollingDice2Label: UILabel!
    @IBOutlet weak var rollingDice3Label: UILabel!
    @IBOutlet weak var rollingDice4Label: UILabel!
    @IBOutlet weak var rollingDice5Label: UILabel!
    @IBOutlet weak var rollingDice6Label: UILabel!
    //MARK: - Variables
    public var count = 1
    
    //references the dice selection view
    let DiceSelectionVc = DiceSelectionViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - Actions
    @IBAction func RollButtonPressed(_ sender: Any) {
        if DiceBag.DiceBag.count > 0 {
            for dice in DiceBag.DiceBag{
                
                switch(dice.sides){
                    case 4:
                        DiceDecider(count: count, sides: dice.sides, textSize: 24, textOffsetX: 0, textOffsetY: 7)
                        break
                    case 6:
                        DiceDecider(count: count, sides: dice.sides, textSize: 32, textOffsetX: -5, textOffsetY: 5)
                        break

                    case 8:
                        DiceDecider(count: count, sides: dice.sides, textSize: 26, textOffsetX: 0, textOffsetY: 2)
                        break

                    case 10:
                        DiceDecider(count: count, sides: dice.sides, textSize: 24, textOffsetX: -5, textOffsetY: 5)
                        break

                    case 12:
                        DiceDecider(count: count, sides: dice.sides, textSize: 24, textOffsetX: -5, textOffsetY: 5)
                        break

                    case 20:
                        DiceDecider(count: count, sides: dice.sides, textSize: 24, textOffsetX: -5, textOffsetY: 5)
                        break
                        
                default:
                    
                        break
                    
                }
                
                count += 1
                
                
                
            }
        }else{
            let ac = UIAlertController(title: "Empty Dice Bag!", message: "Your dice bag has no dice in it", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
        }
        count = 1
    }
    
    //MARK: - Functions
    public func DiceDecider(count : Int, sides : Int, textSize: Int, textOffsetX: Int, textOffsetY: Int){
        switch(count){
        case 1:
            let r = Int.random(in: 1...sides)
            rollingDice1.image = UIImage(named: "d\(sides)")
            rollingDice1Label.text = "\(r)"
            rollingDice1Label.font = rollingDice1Label.font.withSize(CGFloat(textSize))
            let xConstraint = NSLayoutConstraint(item: rollingDice1Label!, attribute: .centerX, relatedBy: .equal, toItem: rollingDice1, attribute: .centerX, multiplier: 1, constant: CGFloat(textOffsetX))

            let yConstraint = NSLayoutConstraint(item: rollingDice1Label!, attribute: .centerY, relatedBy: .equal, toItem: rollingDice1, attribute: .centerY, multiplier: 1, constant: CGFloat(textOffsetY))
            NSLayoutConstraint.activate([xConstraint, yConstraint])
            
//            rollingDice1Label.centerYAnchor.constraint(equalTo: rollingDice1.centerYAnchor).isActive = true
//            rollingDice1Label.centerXAnchor.constraint(equalTo: rollingDice1.centerXAnchor).isActive = true
            break
        case 2:
            let r = Int.random(in: 1...sides)
            rollingDice2.image = UIImage(named: "d\(sides)")
            rollingDice2Label.text = "\(r)"
            rollingDice2Label.font = rollingDice2Label.font.withSize(CGFloat(textSize))
            rollingDice2Label.centerYAnchor.constraint(equalTo: rollingDice2.centerYAnchor).isActive = true
            rollingDice2Label.centerXAnchor.constraint(equalTo: rollingDice2.centerXAnchor).isActive = true
            break
        case 3:
            let r = Int.random(in: 1...sides)
            rollingDice3.image = UIImage(named: "d\(sides)")
            rollingDice3Label.text = "\(r)"
            rollingDice3Label.font = rollingDice3Label.font.withSize(CGFloat(textSize))
            rollingDice3Label.centerYAnchor.constraint(equalTo: rollingDice3.centerYAnchor).isActive = true
            rollingDice3Label.centerXAnchor.constraint(equalTo: rollingDice3.centerXAnchor).isActive = true
            break
            
        case 4:
            let r = Int.random(in: 1...sides)
            rollingDice4.image = UIImage(named: "d\(sides)")
            rollingDice4Label.text = "\(r)"
            rollingDice4Label.font = rollingDice4Label.font.withSize(CGFloat(textSize))
            rollingDice4Label.centerYAnchor.constraint(equalTo: rollingDice4.centerYAnchor).isActive = true
            rollingDice4Label.centerXAnchor.constraint(equalTo: rollingDice4.centerXAnchor).isActive = true
            break
            
        case 5:
            let r = Int.random(in: 1...sides)
            rollingDice5.image = UIImage(named: "d\(sides)")
            rollingDice5Label.text = "\(r)"
            rollingDice5Label.font = rollingDice5Label.font.withSize(CGFloat(textSize))
            rollingDice5Label.centerYAnchor.constraint(equalTo: rollingDice5.centerYAnchor).isActive = true
            rollingDice5Label.centerXAnchor.constraint(equalTo: rollingDice5.centerXAnchor).isActive = true
            break
            
        case 6:
            let r = Int.random(in: 1...sides)
            rollingDice6.image = UIImage(named: "d\(sides)")
            rollingDice6Label.text = "\(r)"
            rollingDice6Label.font = rollingDice6Label.font.withSize(CGFloat(textSize))
            rollingDice6Label.centerYAnchor.constraint(equalTo: rollingDice6.centerYAnchor).isActive = true
            rollingDice6Label.centerXAnchor.constraint(equalTo: rollingDice6.centerXAnchor).isActive = true
            break
        default:
            
            break
        }
    }
}

