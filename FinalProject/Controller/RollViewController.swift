//
//  ViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/28/20.
//

import UIKit
import CoreData
class RollViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var RollButton: UIButton!
    
    //Images outlets
    @IBOutlet weak var rollingDice1: UIImageView!
    @IBOutlet weak var rollingDice2: UIImageView!
    @IBOutlet weak var rollingDice3: UIImageView!
    @IBOutlet weak var rollingDice4: UIImageView!
    @IBOutlet weak var rollingDice5: UIImageView!
    @IBOutlet weak var rollingDice6: UIImageView!
    //Label outlets
    @IBOutlet weak var groupLabel: UILabel!
    @IBOutlet weak var rollingLabel: UILabel!
    @IBOutlet weak var rollingDice1Label: UILabel!
    @IBOutlet weak var rollingDice2Label: UILabel!
    @IBOutlet weak var rollingDice3Label: UILabel!
    @IBOutlet weak var rollingDice4Label: UILabel!
    @IBOutlet weak var rollingDice5Label: UILabel!
    @IBOutlet weak var rollingDice6Label: UILabel!
    //Constraint outlets
    @IBOutlet weak var rollingDice1LabelXCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice1LabelYCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice2LabelXCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice2LabelYCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice3LabelXCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice3LabelYCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice4LabelXCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice4LabelYCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice5LabelXCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice5LabelYCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice6LabelXCons: NSLayoutConstraint!
    @IBOutlet weak var rollingDice6LabelYCons: NSLayoutConstraint!
    
    //MARK: - Variables
    public var count = 1
    var coreDataStack = CoreDataStack(modelName: "FinalProject")
    public static var currentGroupPlayers = [String]()
    public static var playerIndexer = 0
    public var currentRoll = [String]()
    
    
    
    //references the dice selection view
    let DiceSelectionVc = DiceSelectionViewController()
    
    //view did load
    override func viewDidLoad() {
        super.viewDidLoad()
        rollingDice1.alpha = 0
        rollingDice2.alpha = 0
        rollingDice3.alpha = 0
        rollingDice4.alpha = 0
        rollingDice5.alpha = 0
        rollingDice6.alpha = 0
        
        PlayerRefresher()
        
        groupLabel.text = "Group: \(GroupDisplayer())"
        rollingLabel.text = "Rolling: \(PlayerDisplayer(currentGroupName: GroupDisplayer()))"
        
        
        
    }
           
    
    override func viewWillAppear(_ animated: Bool) {
        
        PlayerRefresher()
        
        groupLabel.text = "Group: \(GroupDisplayer())"
        rollingLabel.text = "Rolling: \(PlayerDisplayer(currentGroupName: GroupDisplayer()))"
        
        //display player and cycle through players
    }
    

    //MARK: - Actions
    @IBAction func diceClear(_ sender: Any) {
        DiceClear()
    }
    @IBAction func RollButtonPressed(_ sender: Any) {
        currentRoll = []
        //as long as there are dice in the bag
        if DiceBag.DiceBag.count > 0 {
            //loop through them
            for dice in DiceBag.DiceBag{
                
                switch(dice.sides){
                    case 4:
                        //calls our method that handles what the attributes of our dice positions are
                        DiceDecider(count: count, sides: dice.sides, textSize: 29, textOffsetX: -1	, textOffsetY: 8)
                        break
                    case 6:
                        DiceDecider(count: count, sides: dice.sides, textSize: 32, textOffsetX: -5.0, textOffsetY: 5.0)
                        break

                    case 8:
                        DiceDecider(count: count, sides: dice.sides, textSize: 29, textOffsetX: 0, textOffsetY: -1.0)
                        break

                    case 10:
                        DiceDecider(count: count, sides: dice.sides, textSize: 19, textOffsetX: 0, textOffsetY: -7.0)
                        break

                    case 12:
                        DiceDecider(count: count, sides: dice.sides, textSize: 24, textOffsetX: 0, textOffsetY: 1.0)
                        break

                    case 20:
                        DiceDecider(count: count, sides: dice.sides, textSize: 14, textOffsetX: 0, textOffsetY: 0)
                        break
                        
                default:
                    
                        break
                    
                }
                
                count += 1
                
                
            }
            
            AddHistory()
            //Increments the player in order
            if (RollViewController.playerIndexer + 1 >= RollViewController.currentGroupPlayers.count){
                RollViewController.playerIndexer = 0
            }else{
                RollViewController.playerIndexer += 1
            }
            
            rollingLabel.text = "Rolling: \(PlayerDisplayer(currentGroupName: GroupDisplayer()))"
            
        }else{
            //alerts the user that they have no dice
            let ac = UIAlertController(title: "Empty Dice Bag!", message: "Your dice bag has no dice in it", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            
            present(ac, animated: true)
        }
        count = 1
        
        
    }
    
    //MARK: - Functions
    public func GroupDisplayer() -> String {
        //Fetch request for selected
        let fetchRequest: NSFetchRequest<Selected> = Selected.fetchRequest()
        //assigns our return string
        var currentGroupName: String = ""
        do{
            //fetches results with coredata
            let fetchedResults = try coreDataStack.managedContext.fetch(fetchRequest)
            for results in fetchedResults{
                //we only want the selected object
                if results.currently_selected{
                    //assign our variable to the text of the group name
                    currentGroupName = results.group.group_name
                }
            }
        }catch{
            print(error)
            //probably dont need this return
            return currentGroupName
        }
        //return
        return currentGroupName
    }
    
    public func PlayerRefresher(){
        RollViewController.currentGroupPlayers = []
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "group.group_name == %@", GroupDisplayer())
        
       
        do{
            let fetchedResults = try coreDataStack.managedContext.fetch(fetchRequest)
            for results in fetchedResults {
                RollViewController.currentGroupPlayers.append(results.name)
            }
        }catch{
            print(error)
        }
    }
    
    public func HistoryProcessor() -> String{
        var historyString = ""
        for roll in currentRoll{
            historyString += roll
        }
        return historyString
    }
    
    public func AddHistory(){
        
        let fetchRequest: NSFetchRequest<Group> = Group.fetchRequest()
        //searches for group matching our currently selected group name
        fetchRequest.predicate = NSPredicate(format: "group_name == %@", GroupDisplayer())
        do{
            let fetchedResults = try coreDataStack.managedContext.fetch(fetchRequest)
            
            //assigns our group variable
            let currentGroup = fetchedResults.first!
            
            
        
        //create a new object and insert into the context
        let newHistory = History(context: coreDataStack.managedContext)
        //fills out object with required info
        newHistory.playerName = PlayerDisplayer(currentGroupName: GroupDisplayer())
        newHistory.rollHistory = "\(HistoryProcessor())"
            
        
        //adds history to our group
        currentGroup.addToHistory(newHistory)
        
        
        //save the context (with the new Group)
        coreDataStack.saveContext()
        
        }
        catch{
            print(error)
            
        }
        
    }
    
    public func DiceClear(){
        rollingDice1.alpha = 0
        rollingDice2.alpha = 0
        rollingDice3.alpha = 0
        rollingDice4.alpha = 0
        rollingDice5.alpha = 0
        rollingDice6.alpha = 0
    }
     
    public func PlayerDisplayer(currentGroupName: String) -> String {
        //Fetch request for player
        let fetchRequest: NSFetchRequest<Player> = Player.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "group.group_name == %@", currentGroupName)
        //assigns our return string
        
        var currentPlayerName: String = ""
        do{
            //fetches results with coredata
            let fetchedResults = try coreDataStack.managedContext.fetch(fetchRequest)
           
            currentPlayerName = fetchedResults[RollViewController.playerIndexer].name
            print(RollViewController.playerIndexer)
             
        }catch{
            print(error)
            //probably dont need this return
            return currentPlayerName
        }
        //return
        return currentPlayerName
    }
    
    
    public func DiceDecider(count : Int, sides : Int, textSize: Int, textOffsetX: CGFloat, textOffsetY: CGFloat){
        //counts for each dice position on the storyboard
        switch(count){
        //if first dice position
        case 1:
            rollingDice1.alpha = 1
            //randomizes the dice value from 1 - dice sides
            let r = Int.random(in: 1...sides)
            //changes the image to the correct dice image
            rollingDice1.image = UIImage(named: "d\(sides)")
            //visually changes text on dice
            rollingDice1Label.text = "\(r)"
            //changes dice text to appropriate text size
            rollingDice1Label.font = rollingDice1Label.font.withSize(CGFloat(textSize))
            //changes positioning of the dice text
            rollingDice1LabelXCons.constant = textOffsetX
            rollingDice1LabelYCons.constant = textOffsetY
            view.layoutIfNeeded()
            currentRoll.append("d\(sides) - Rolled \(r)\n")
            break
        case 2:
            rollingDice2.alpha = 1
            let r = Int.random(in: 1...sides)
            rollingDice2.image = UIImage(named: "d\(sides)")
            rollingDice2Label.text = "\(r)"
            rollingDice2Label.font = rollingDice2Label.font.withSize(CGFloat(textSize))
            rollingDice2LabelXCons.constant = textOffsetX
            rollingDice2LabelYCons.constant = textOffsetY
            view.layoutIfNeeded()
            currentRoll.append("d\(sides) - Rolled \(r)\n")
            break
        case 3:
            rollingDice3.alpha = 1
            let r = Int.random(in: 1...sides)
            rollingDice3.image = UIImage(named: "d\(sides)")
            rollingDice3Label.text = "\(r)"
            rollingDice3Label.font = rollingDice3Label.font.withSize(CGFloat(textSize))
            rollingDice3LabelXCons.constant = textOffsetX
            rollingDice3LabelYCons.constant = textOffsetY
            view.layoutIfNeeded()
            break
            
        case 4:
            rollingDice4.alpha = 1
            let r = Int.random(in: 1...sides)
            rollingDice4.image = UIImage(named: "d\(sides)")
            rollingDice4Label.text = "\(r)"
            rollingDice4Label.font = rollingDice4Label.font.withSize(CGFloat(textSize))
            rollingDice4LabelXCons.constant = textOffsetX
            rollingDice4LabelYCons.constant = textOffsetY
            view.layoutIfNeeded()
            currentRoll.append("d\(sides) - Rolled \(r)\n")
            break
            
        case 5:
            rollingDice5.alpha = 1
            let r = Int.random(in: 1...sides)
            rollingDice5.image = UIImage(named: "d\(sides)")
            rollingDice5Label.text = "\(r)"
            rollingDice5Label.font = rollingDice5Label.font.withSize(CGFloat(textSize))
            rollingDice5LabelXCons.constant = textOffsetX
            rollingDice5LabelYCons.constant = textOffsetY
            view.layoutIfNeeded()
            currentRoll.append("d\(sides) - Rolled \(r)\n")
            break
            
        case 6:
            rollingDice6.alpha = 1
            let r = Int.random(in: 1...sides)
            rollingDice6.image = UIImage(named: "d\(sides)")
            rollingDice6Label.text = "\(r)"
            rollingDice6Label.font = rollingDice6Label.font.withSize(CGFloat(textSize))
            rollingDice6LabelXCons.constant = textOffsetX
            rollingDice6LabelYCons.constant = textOffsetY
            view.layoutIfNeeded()
            currentRoll.append("d\(sides) - Rolled \(r)\n")
            break
        default:
            
            break
        }
    }
}

