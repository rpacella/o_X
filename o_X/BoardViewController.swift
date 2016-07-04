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
        
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
//        let onCompletion = {(string : String?) in
        
            let storyboard = UIStoryboard(name: "onBoarding", bundle: nil)
            
            let viewController = storyboard.instantiateInitialViewController()
            
            let application = UIApplication.sharedApplication()
            
            let window = application.keyWindow
            
            window?.rootViewController = viewController
            
//            }
        
//        UserController.sharedInstance.logout(onCompletion())
        
    }
}




