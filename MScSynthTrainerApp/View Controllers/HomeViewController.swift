//
//  HomeViewController.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 21/06/2022.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    // 5/7/22 - Launching HomeVCSwiftUIView file from this HomeViewController
    // www.youtube.com/watch?v=aWL7W8SLfeo&ab_channel=JawaadSheikh
    
    @IBOutlet weak var theContainer : UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let childView = UIHostingController(rootView: HomeVCSwiftUIView())
        addChild(childView)
        childView.view.frame = theContainer.bounds
        theContainer.addSubview(childView.view)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
