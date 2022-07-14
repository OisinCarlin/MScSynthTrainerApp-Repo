//
//  Service.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 14/07/2022.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class Service {
    
    func getUserData() {
        
        // 11/7/22: Capturing user data from Firebase to store upon Login
        let db = Firestore.firestore()
        let uid = Auth.auth().currentUser?.uid
        
//        let defaults = UserDefaults.standard
        
        db.collection("users").whereField("uid", isEqualTo: uid!)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
//                        print("\(document.documentID) => \(document.data())")
                        
//                        let data = document.data()
                        let docID = document.documentID
                        let userID = document["uid"] as? String ?? ""
                        let userFirstName = document["firstname"] as? String ?? ""
                        let userLastName = document["lastname"] as? String ?? ""
                        
//                        defaults.set(docID, forKey: "userDocumentID")
//                        defaults.set(userID, forKey: "userID")
//                        defaults.set(userFirstName, forKey: "userFirstName")
//                        defaults.set(userLastName , forKey: "userLastName")
                        
//                        UserDefaults.standard.setLoggedIn(value: true)
                        UserDefaults.standard.setUserDocumentID(value: docID)
                        UserDefaults.standard.setUserID(value: userID)
                        UserDefaults.standard.setUserFirstName(value: userFirstName)
                        UserDefaults.standard.setUserLastName(value: userLastName)
                        
                }
            }
// =============================================================================================
    
}

}
}
