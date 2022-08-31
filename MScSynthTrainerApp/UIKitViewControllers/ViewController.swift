//
//  ViewController.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 21/06/2022.
//
// First 'Welcome' UIKit ViewController presented upon Application Initialisation
//
// Ref: (Sheikh, 2020): www.youtube.com/watch?v=aWL7W8SLfeo&ab_channel=JawaadSheikh
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    // 5/7/22: Unwinding methods for Back Buttons on SignUpViewController and LoginViewController
    @IBAction func unwindToInitialVC(sender : UIStoryboardSegue)
    {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setUpElements()
    }
    
    func setUpElements() {
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
}

