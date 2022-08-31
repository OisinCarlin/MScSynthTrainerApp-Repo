//
//  LoginViewController.swift
//  MScSynthTrainerApp
//  Created by Oisin Carlin on 21/06/2022.
//
// Log-in UIKit Viewcontroller Accompanying Code File
//
// Ref: (Ching, 2019): www.youtube.com/watch?v=1HN7usMROt8&t=2309s&ab_channel=CodeWithChris
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
                let db = Firestore.firestore()
                let uid = Auth.auth().currentUser?.uid
                
                db.collection("users").whereField("uid", isEqualTo: uid!)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error getting documents: \(err)")
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                                
                                let docID = document.documentID
                                let userID = document["uid"] as? String ?? ""
                                let userFirstName = document["firstname"] as? String ?? ""
                                let userLastName = document["lastname"] as? String ?? ""
                                
                                // Test collection of User Data from Firebase User Document
                                print ("                                                         ")
                                print ("**** Start Printing Firebase Document Snapshot Data *****")
                                print ("                                                         ")
                                print ("First name: " + userFirstName)
                                print ("Last name: " + userLastName)
                                print ("User ID" + userID)
                                print ("Document ID: " + docID)
                                print ("                                                         ")
                                print ("**** End Printing Firebase Document Snapshot Data *****")
                                print ("                                                         ")
                                
                                // Setting UserDefaults for User Data
                                UserDefaults.standard.setUserDocumentID(value: docID)
                                UserDefaults.standard.setUserID(value: userID)
                                UserDefaults.standard.setUserFirstName(value: userFirstName)
                                UserDefaults.standard.setUserLastName(value: userLastName)
                                
                                // Test UserDefaults Getters for User Data
                                print ("                                                         ")
                                print ("**** Start Printing User Defaults Getters *****")
                                print ("                                                         ")
                                print("First name: " + UserDefaults.standard.getUserFirstName())
                                print("Last name: " + UserDefaults.standard.getUserLastName())
                                print("User ID" + UserDefaults.standard.getUserID())
                                print("Document ID: " + UserDefaults.standard.getUserDocumentID())
                                print ("                                                         ")
                                print ("**** End Printing User Defaults Getters *****")
                                print ("                                                         ")
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


