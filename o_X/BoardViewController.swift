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
    
    @IBOutlet weak var gameStateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
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
    }
    
    // Create additional IBActions here.
    
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
        
        if gameState == OXGameState.Won {
            if OXGameController.sharedInstance.getCurrentGame().whoseTurn() == CellType.X
                    {gameStateLabel.text = "Player X Won!"}
            else {gameStateLabel.text = "Player O Won!"
            }
        }
        if gameState == OXGameState.Tie {
            gameStateLabel.text = "Tie!"
            
        }
        
//        else if (OXGameController.sharedInstance.getCurrentGame().turnCount() == 9) {
//            OXGameController.sharedInstance.getCurrentGame().reset()
//        }
        
    }
    
    @IBAction func logOutButtonPressed(sender: AnyObject) {
        print("logout button pressed")
    }
    
    
}