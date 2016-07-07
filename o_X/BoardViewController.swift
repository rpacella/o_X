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
    
    var networkMode :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if networkMode {updateUI("xo____x_o")}
       
//          newGameButton.hidden = true
//        messageArea.text = OXGameController.sharedInstance.getCurrentGame().state()
    
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
    
    @IBAction func cellButtonPressed(sender: AnyObject) {
  
        let player = OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(player.rawValue, forState: .Normal)
        
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
        
    func updateUI(boardString: String) {
        
        let board = OXGameController.sharedInstance.getCurrentGame().deserialiseBoard(boardString)
    OXGameController.sharedInstance.getCurrentGame().board = board
        
        var count = 0
        for subView in boardView.subviews {
            if let button = subView as? UIButton {
                button.setTitle(board[count].rawValue, forState: .Normal)
            }
            count += 1
        }

        

    }
}




}