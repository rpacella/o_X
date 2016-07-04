//
//  RegisterViewController.swift
//  o_X
//
//  Created by Riley Pacella on 6/30/16.
//  Copyright © 2016 iX. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBAction func registerButtonPressed(sender: AnyObject) {
        
        let onCompletion = { (currentUser : User?, error: String?) in
            if currentUser == nil {
                let errorMessage : String = error!
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
                })
                errorAlert.addAction(dismissErrorAlert)
                self.presentViewController(errorAlert, animated: true, completion: nil)
                return
            }
            else if currentUser != nil {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateInitialViewController()
                let application = UIApplication.sharedApplication()
                let window = application.keyWindow
                window?.rootViewController = viewController
            }
        }
        
        UserController.sharedInstance.currentUser?.email = emailTextField.text!
        UserController.sharedInstance.currentUser?.password = passwordTextField.text!
        UserController.sharedInstance.register(emailTextField.text!, password: passwordTextField.text!, onCompletion: onCompletion)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
