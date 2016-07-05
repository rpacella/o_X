//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    @IBOutlet weak var button0: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet weak var button5: UIButton!
    
    @IBOutlet weak var button6: UIButton!
    
    @IBOutlet weak var button7: UIButton!
    
    @IBOutlet weak var button8: UIButton!
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var boardView: UIView!
    
    @IBOutlet weak var messagingArea: UILabel!
    
    var networkMode :Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//updateUI("x_o___x_o")
    newGameButton.hidden = true
    
    }
    
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        OXGameController.sharedInstance.restartGame()
        
        button0.setTitle("", forState: UIControlState.Normal)
        button1.setTitle("", forState: UIControlState.Normal)
        button2.setTitle("", forState: UIControlState.Normal)
        button3.setTitle("", forState: UIControlState.Normal)
        button4.setTitle("", forState: UIControlState.Normal)
        button5.setTitle("", forState: UIControlState.Normal)
        button6.setTitle("", forState: UIControlState.Normal)
        button7.setTitle("", forState: UIControlState.Normal)
        button8.setTitle("", forState: UIControlState.Normal)
        
        newGameButton.hidden = true

    }
    
    @IBAction func cellButtonPressed(sender: AnyObject) {
    
        OXGameController.sharedInstance.playMove(sender.tag)
        
        let newTitle = String(OXGameController.sharedInstance.getCurrentGame().whoseTurn())
            switch sender.tag {
                case 1 : button1.setTitle(newTitle, forState: UIControlState.Normal)
                case 2 : button2.setTitle(newTitle, forState: UIControlState.Normal)
                case 3 : button3.setTitle(newTitle, forState: UIControlState.Normal)
                case 4 : button4.setTitle(newTitle, forState: UIControlState.Normal)
                case 5 : button5.setTitle(newTitle, forState: UIControlState.Normal)
                case 6 : button6.setTitle(newTitle, forState: UIControlState.Normal)
                case 7 : button7.setTitle(newTitle, forState: UIControlState.Normal)
                case 8 : button8.setTitle(newTitle, forState: UIControlState.Normal)
                case 0 : button0.setTitle(newTitle, forState: UIControlState.Normal)

            default:
                print("No tag")
            }
        
    let gameState = OXGameController.sharedInstance.getCurrentGame().state()
    
    if (gameState == OXGameState.Won) {
            if (OXGameController.sharedInstance.getCurrentGame().whoseTurn() == CellType.X) {
                
                let alert = UIAlertController(title: "Game Over", message: "'X' Won!", preferredStyle: UIAlertControllerStyle.Alert)
                
                let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    
                    self.newGameButton.hidden = false
                })
                
                alert.addAction(dismissAlertAction)
                
                self.presentViewController(alert, animated: true, completion: nil)
            }
            
            else {
                let alert = UIAlertController(title: "Game Over", message: "'O' Won!", preferredStyle: UIAlertControllerStyle.Alert)
                
                let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    
                    self.newGameButton.hidden = false
                })
                
                alert.addAction(dismissAlertAction)
                
                self.presentViewController(alert, animated: true, completion: nil)

            }
    }
    
        
        if gameState == OXGameState.Tie {
                
                let alert = UIAlertController(title: "Game Over", message: "Tie", preferredStyle: UIAlertControllerStyle.Alert)
                
                let dismissAlertAction = UIAlertAction(title: "Dismiss", style: .Cancel, handler: { (action) in
                    self.newGameButton.hidden = false
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
        
        var board = OXGameController.sharedInstance.getCurrentGame()
        
        for cell in board {
            
        }

        
        

    }
}




