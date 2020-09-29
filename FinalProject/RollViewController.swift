//
//  ViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/28/20.
//

import UIKit

class ViewController: UIViewController {
    //creats the dice selection view controller
    let DiceSelectionVc = UIViewController();
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func didTouchButton(_ sender: Any) {
        //populates the diceselectionvc
        DiceSelectionVc.view.backgroundColor = .red
        DiceSelectionVc.title = "Dice Selection"
        navigationController?.pushViewController(DiceSelectionVc, animated: true)
    }
    

}

