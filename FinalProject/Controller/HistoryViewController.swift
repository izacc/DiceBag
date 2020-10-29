//
//  HistoryViewController.swift
//  FinalProject
//
//  Created by Izacc Casey-Lucas on 9/29/20.
//

import UIKit

class HistoryViewController: UITableViewController {
    let playersRolled = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        }
    
    
    
   
}
extension HistoryViewController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playersRolled.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath)

        cell.textLabel?.text = playersRolled[indexPath.row]
        cell.detailTextLabel?.text = "d6 - Rolled 4 \nd10 - rolled 5\nd6 - Rolled 4 \nd10 - rolled 5\nd6 - Rolled 4 \nd10 - rolled 5\n"
        return cell
    }
}
