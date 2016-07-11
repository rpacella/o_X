//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var messagingArea: UILabel!
    
    @IBOutlet weak var messageArea: UILabel!
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    var networkMode :Bool = false
    
    
    @IBAction func refreshGamePushed(sender: AnyObject) {
            OXGameController.sharedInstance.getGame { (updatedGame, message) in
            if updatedGame != nil {
                print(OXGameController.sharedInstance.getCurrentGame().serialiseBoard())
                self.updateUI()
            }
            else if message != nil {
                let errorMessage : String = message!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
                })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        gameStateLabel.text = OXGameController.sharedInstance.getCurrentGame().gameState.rawValue
    }
    
    
    
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        
        OXGameController.sharedInstance.restartGame()
        
        for subView in boardView.subviews {
            if let button = subView as? UIButton {
                button.setTitle("", forState: .Normal)
                button.enabled = true
            }
        }
                newGameButton?.hidden = true

    }
    
    
    @IBAction func cancelGameButtonPressed(sender: AnyObject) {
        OXGameController.sharedInstance.cancelGame({ message in
            if message != nil {
                let errorMessage : String = message!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
            }
            else if message == nil {
                self.navigationController?.popViewControllerAnimated(true)
            }
        })
    }

    @IBAction func cellButtonPressed(sender: AnyObject) {
  
        let player = OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(player.rawValue, forState: .Normal)
        
        if networkMode {
            
            OXGameController.sharedInstance.networkPlayMove({message in
              
                if message != nil {
                    let errorMessage : String = message!
                    let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                    let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in })
                    errorAlert.addAction(dismissErrorAlert)
                    self.presentViewController(errorAlert, animated: true, completion: nil)
                }
                })
        }
        
        if let button = sender as? UIButton {
            button.enabled = false
        }
        
        print(OXGameController.sharedInstance.getCurrentGame().serialiseBoard())
        
        let gameState = OXGameController.sharedInstance.getCurrentGame().state()
        
        if (gameState == OXGameState.Won) {
            if (OXGameController.sharedInstance.getCurrentGame().whoJustPlayed() == CellType.X) {
                
                let alert = UIAlertController(title: "Game Over", message: "'X' Won!", preferredStyle: UIAlertControllerStyle.Alert)
                
                let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    
                    self.newGameButton?.hidden = false
                })
                
                alert.addAction(dismissAlertAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                for subview in boardView.subviews {
                    if let button = subview as? UIButton {
                        button.enabled = false
                    }
                
                }
            }
            
            else if (OXGameController.sharedInstance.getCurrentGame().whoJustPlayed() == CellType.O){
                let alert = UIAlertController(title: "Game Over", message: "'O' Won!", preferredStyle: UIAlertControllerStyle.Alert)
                
                let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    
                    self.newGameButton?.hidden = false
                })
                
                alert.addAction(dismissAlertAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
                for subview in boardView.subviews {
                    if let button = subview as? UIButton {
                    button.enabled = false
                    }
    
                }
            }
        }
        
        if gameState == OXGameState.Tie {
            
            let alert = UIAlertController(title: "Game Over", message: "Tie", preferredStyle: UIAlertControllerStyle.Alert)
            
            let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                self.newGameButton?.hidden = false
            })
            alert.addAction(dismissAlertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
    
            for subview in boardView.subviews {
                if let button = subview as? UIButton {
                    button.enabled = false
                }

            }

        }
    }


    @IBAction func logOutButtonPressed(sender: AnyObject) {
        let onCompletion = {(string : String?) in
        
            let storyboard = UIStoryboard(name: string!, bundle: nil)
            
            let viewController = storyboard.instantiateInitialViewController()
            
            let application = UIApplication.sharedApplication()
            
            let window = application.keyWindow
            
            window?.rootViewController = viewController
            
        }
        
        UserController.sharedInstance.logout(onCompletion)
        
        }
        
func updateUI() {
        var board = OXGameController.sharedInstance.getCurrentGame().board
    
        for subView in boardView.subviews {
            if let button = subView as? UIButton {
                button.setTitle(board[button.tag].rawValue, forState: .Normal)
            }
        }

        

    }
}