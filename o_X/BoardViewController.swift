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
            }
        }
                newGameButton?.hidden = true

    }
    
    @IBAction func cellButtonPressed(sender: AnyObject) {
  
        var player = OXGameController.sharedInstance.playMove(sender.tag)
        sender.setTitle(player.rawValue, forState: .Normal)
        
//        sender.enabled = false
        
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
                
            }
        }
        
        
        if gameState == OXGameState.Tie {
            
            let alert = UIAlertController(title: "Game Over", message: "Tie", preferredStyle: UIAlertControllerStyle.Alert)
            
            let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                self.newGameButton?.hidden = false
            })
            alert.addAction(dismissAlertAction)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
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
        
        /*
         * BoardViewController's updateUI() function
         * Although we haven't completed full network functionality yet,
         * this function will come in handy when we have to display our opponents moves
         * that we obtain from the networking layers (more on that later)
         * For now, you are required to implement this function in connection with Activity 1 from todays class
         * Hint number 1: This function must set the values of O and X on the board, based on the games board array values. Does this kind of remind you of the resetBoard or newGameTapped function???
         * Hint number 2: if you set your board array to private in the OXGame class, maybe you should set it now to 'not private' ;)
         * Hint number 3: call this function in BoardViewController's viewDidLoad function to see it execute what board was set in the game's initialiser on your screen!
         * And Go!
         */
        let board = OXGameController.sharedInstance.getCurrentGame().deserialiseBoard(boardString)
    OXGameController.sharedInstance.getCurrentGame().board = board
        
//        print(board)
//        print(OXGameController.sharedInstance.getCurrentGame().board)
        var count = 0
        for subView in boardView.subviews {
            if let button = subView as? UIButton {
                button.setTitle(board[count].rawValue, forState: .Normal)
            }
            count += 1
        }

        

    }
}




