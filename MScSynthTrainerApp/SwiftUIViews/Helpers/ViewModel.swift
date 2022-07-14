//
//  ViewModel.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 14/07/2022.
//

import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class ViewModel : ObservableObject {
    
    @Published var list = [Todo]()
    
    func getData(){
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Read the documents at a specific path
        db.collection("users").getDocuments { snapshot, error in
            
            // Check for error
            if error == nil {
                // No errors
                
                if let snapshot = snapshot {
                    
                    // Update the list property in the main thread
                    DispatchQueue.main.async {
                        //Get all the documents and create todos
                        // 'd' for document
                        self.list = snapshot.documents.map { d in
                            return Todo(id: d.documentID,
                                        uid: d["uid"] as? String ?? "",
                                        firstName: d["firstName"] as? String ?? "",
                                        lastName: d["lastName"] as? String ?? "")
                        }
                    }

                }
            }
            else {
                // Handle the error
            }
        }
        
        
    }
}

