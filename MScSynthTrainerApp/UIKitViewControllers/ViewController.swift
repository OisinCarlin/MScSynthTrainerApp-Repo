//
//  ViewController.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 21/06/2022.
//
// First 'Welcome' UIKit ViewController presented upon Application Initialisation
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var signUpButton: UIButton!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    // 5/7/22: Unwinding methods for Back Buttons on SignUpViewController and LoginViewController
    // www.youtube.com/watch?v=aWL7W8SLfeo&ab_channel=JawaadSheikh
    
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

