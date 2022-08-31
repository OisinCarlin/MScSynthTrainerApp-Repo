//
//  UserDefaults.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 14/07/2022.
//
// Defining Application UserDefaults Storage variables, Getters and Setters.
// Stores Logged-in User details from Firebase database
//
// Ref: (Voong, 2016): www.youtube.com/watch?v=gjYAIXjpIS8&t=888s&ab_channel=LetsBuildThatApp
//

import Foundation

enum UserDefaultsKeys : String {
    case userDocumentID
    case userID
    case userFirstName
    case userLastName
}

extension UserDefaults{
    
    //MARK: Save User Data
    func setUserDocumentID(value: String){
        set(value, forKey: UserDefaultsKeys.userDocumentID.rawValue)
        synchronize()
    }
    
    //MARK: Retrieve User Data
    func getUserDocumentID() -> String{
        return string(forKey: UserDefaultsKeys.userDocumentID.rawValue) ?? ""
    }
    
    
    func setUserID(value: String){
        set(value, forKey: UserDefaultsKeys.userID.rawValue)
        synchronize()
    }
    
    //MARK: Retrieve User Data
    func getUserID() -> String{
        return string(forKey: UserDefaultsKeys.userID.rawValue) ?? ""
    }
    
    func setUserFirstName(value : String){
        set(value, forKey: UserDefaultsKeys.userFirstName.rawValue)
        synchronize()
    }
    
    func getUserFirstName() -> String{
        return string(forKey: UserDefaultsKeys.userFirstName.rawValue) ?? ""
    }
    
    func setUserLastName(value : String){
        set(value, forKey: UserDefaultsKeys.userLastName.rawValue)
        synchronize()
    }
    
    func getUserLastName() -> String{
        return string(forKey: UserDefaultsKeys.userLastName.rawValue) ?? ""
    }
}
