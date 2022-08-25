//
//  LoginViewController.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 21/06/2022.
//
//
// Log-in UIKit Viewcontroller Accompanying Code File
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        // Hide the error label
        errorLabel.alpha = 0
        
        // Style the elements
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(loginButton)
    }
    
    
    
    
    
    @IBAction func loginTapped(_ sender: Any) {
        
        // TODO: Validate Text Fields
        
        // Create cleaned version of the text fields
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Signing in the user
        Auth.auth().signIn(withEmail: email, password: password) {
            (result, error) in
            
            if error != nil {
                // Couldn't sign in
                self.errorLabel.text = error!.localizedDescription
                self.errorLabel.alpha = 1
            }
            else {
                
                // 11/7/22: Capturing user data from Firebase to store upon Login
                // Make this functionality available after Signing Up too, or transition to Login Instead
                let db = Firestore.firestore()
                let uid = Auth.auth().currentUser?.uid
                
                
                db.collection("users").whereField("uid", isEqualTo: uid!)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                                
                                // let data = document.data()
                                let docID = document.documentID
                                let userID = document["uid"] as? String ?? ""
                                let userFirstName = document["firstname"] as? String ?? ""
                                let userLastName = document["lastname"] as? String ?? ""
                                
                                print (userFirstName)
                                //
                                
                                UserDefaults.standard.setUserDocumentID(value: docID)
                                UserDefaults.standard.setUserID(value: userID)
                                UserDefaults.standard.setUserFirstName(value: userFirstName)
                                UserDefaults.standard.setUserLastName(value: userLastName)
                                
                                // Set Login status boolean
                                UserDefaults.standard.setLoggedIn(value: true)
                                
                            }
                        }
                    }
                
                
                // Transition to Home ViewController
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
        }
        
        
    }
    
}


