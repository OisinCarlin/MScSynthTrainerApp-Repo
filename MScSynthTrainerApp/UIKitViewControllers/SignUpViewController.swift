//
//  SignUpViewController.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 21/06/2022.
//
// Sign-Up UIKit Viewcontroller Accompanying Code File
//
// Ref: (Ching, 2019) : www.youtube.com/watch?v=1HN7usMROt8&t=2309s&ab_channel=CodeWithChris
//

import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
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
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(signUpButton)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    // Check the fields and validate that the data is correct.
    // If everything is correct, this method returns nil. Otherwise it returns the error message.
    func validateFields() -> String? {
        
        //Check that all the fields are filled in
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return "Please fill in all fields."
        }
        
        // Check if the password is secure
        let cleanePassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanePassword) == false {
            //Password isn't secure enough
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    
    
    @IBAction func signUpTapped(_ sender: Any) {
        // Validate the fields
        let error = validateFields()
        // Error/validateFields method returns nil if no problems, or returns error message if there is a problem.
        // Therefore, if error/validateFields does NOT return nil AKA there IS a problem...
        if error != nil {
            //There's something wrong with the fields, show error message
            showError(error!)
        } else {
            // Create cleaned versions of the data
            let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            // Create the user in Users Database with their Email and Password
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                
                // Check for errors
                if err != nil{
                    // There was an error creating the user
                    self.showError("Error creating user")
                } else {
                    // User was created successfully.
                    // Now store the firstName, lastname and UID from result of User Database Object in Firestore Database
                    let db = Firestore.firestore()
                    
                    // Create user data document in Firestore, add data.
                    db.collection("users").addDocument(data: ["firstname":firstName,
                                                              "lastname":lastName, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            // Show error message
                            self.showError("Error saving user data")
                        }
                    }
                    // Start of Get Document Code
                    let addDocUserID = result!.user.uid
                    
                    db.collection("users").whereField("uid", isEqualTo: addDocUserID)
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
                                    print ("User ID: " + userID)
                                    print ("Document ID: " + docID)
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
                                    print("First name: " +  UserDefaults.standard.getUserFirstName())
                                    print("Last name: " + UserDefaults.standard.getUserLastName())
                                    print("User ID: " + UserDefaults.standard.getUserID())
                                    print("Document ID: " + UserDefaults.standard.getUserDocumentID())
                                    print ("                                                         ")
                                    print ("**** End Printing User Defaults Getters *****")
                                    print ("                                                         ")
                                }
                            }
                        }
                    // End of Get Document Code
                    
                    // Transition to the home screen
                    self.transitionToHome()
                }
            }
        }
    }
    
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    // Transition to Home ViewController
    func transitionToHome(){
        
        // 11/7/22: Capturing user data from Firebase to store upon Login
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
        
        db.collection("users").whereField("uid", isEqualTo: uid!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        // print("\(document.documentID) => \(document.data())")
                        
                        // let data = document.data()
                        let docID = document.documentID
                        let userID = document["uid"] as? String ?? ""
                        let userFirstName = document["firstname"] as? String ?? ""
                        let userLastName = document["lastname"] as? String ?? ""
                        
                        
                        UserDefaults.standard.setUserDocumentID(value: docID)
                        UserDefaults.standard.setUserID(value: userID)
                        UserDefaults.standard.setUserFirstName(value: userFirstName)
                        UserDefaults.standard.setUserLastName(value: userLastName)
                    }
                }
            }
        
        
        
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        self.view.window?.rootViewController = homeViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    // Transitioning to LoginVC instead of HomeVC
    // Assigned "LoginVC" to LoginViewController's Storyboard ID
    // Clicked on Login View Controller's square button and Assigned under Custom Class - Identity
    // Also added this Storyboard ID to Constants.swift file
    func transitionToLogin(){
        
        let loginViewController = storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? LoginViewController
        
        view.window?.rootViewController = loginViewController
        view.window?.makeKeyAndVisible()
    }

}

