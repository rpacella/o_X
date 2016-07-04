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
            
//                if let errorMessage = error! as? String {
            if currentUser == nil {
                
                print("lalal")
            
                let errorMessage : String = error!
                
                let errorAlert = UIAlertController(title: "Error", message: errorMessage, preferredStyle: UIAlertControllerStyle.Alert)
                
                let dismissErrorAlert = UIAlertAction(title: "Dismiss", style: .Default, handler: { (action) in
                    
                })
                
                errorAlert.addAction(dismissErrorAlert)
                
                
                self.presentViewController(errorAlert, animated: true, completion: nil)
                
            }  else if currentUser != nil{
                
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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
