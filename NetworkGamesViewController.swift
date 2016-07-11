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
    
    @IBAction func hostGameButtonPressed(sender: AnyObject) {
        OXGameController.sharedInstance.hostGame({ newGame, message in
            if newGame != nil {
                self.performSegueWithIdentifier("networkSegue", sender: self)
            }
            else if message != nil {
                let errorMessage : String = message!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
                })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                return
                
            }
            
            return
        })

    }
    
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
            else {
                let errorMessage : String = message!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
                })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                return
            }
        }
        
    }
    
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
        print(indexPath.row)
        OXGameController.sharedInstance.joinGame(indexPath.row, gameArray: games, onCompletion: { newGame, message in
            if newGame != nil {
             self.performSegueWithIdentifier("networkSegue", sender: self)
            }
            else if message != nil {
                let errorMessage : String = message!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
                })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                return

            }

            return
        })
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let destinationVC = segue.destinationViewController as? BoardViewController {
            destinationVC.networkMode = true
        }
    }

}
