//
//  BoardViewController.swift
//  o_X
//

import UIKit

class BoardViewController: UIViewController {
    
    
    @IBOutlet weak var newGameButton: UIButton!
    
    @IBOutlet weak var boardView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func newGameButtonPressed(sender: UIButton) {
        print("New game button pressed.")
    }
    
    // Create additional IBActions here.
    
    @IBAction func cellButtonPressed(sender: AnyObject) {
        
        switch sender.tag {
        case 1:
            print("button 1 pressed")
        case 2:
            print("button 2 pressed")
        case 3:
            print("button 3 pressed")
        case 4:
            print("button 4 pressed")
        case 5:
            print("button 5 pressed")
        case 6:
            print("button 6 pressed")
        case 7:
            print("button 7 pressed")
        case 8:
            print("button 8 pressed")
        case 9:
            print("button 9 pressed")
        default:
            print("default")

        }
    }
    
    @IBAction func logOutButtonPressed(sender: AnyObject) {
        print("logout button pressed")
    }
    
    
}