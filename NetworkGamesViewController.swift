//
//  NetworkGamesViewController.swift
//  o_X
//
//  Created by Riley Pacella on 7/4/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class NetworkGamesViewController: UITableViewController {
    
    var games = [OXGame]()
    
    @IBAction func dismissModalViewController(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OXGameController.sharedInstance.getGameList { games, message in
            if let games = games {
                self.games = games
                self.tableView.reloadData()
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return games.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CellIdentifier", forIndexPath: indexPath)
        cell.textLabel?.text = "ID:  \(games[indexPath.row].ID) Host \(games[indexPath.row].host)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       self.performSegueWithIdentifier("networkSegue", sender: self)
        return
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? BoardViewController {
            destinationVC.networkMode = true
        }
    }
 

}
