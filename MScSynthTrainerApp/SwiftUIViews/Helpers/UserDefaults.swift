//
//  UserDefaults.swift
//  MScSynthTrainerApp
//
//  Created by Oisin Carlin on 14/07/2022.
//

import Foundation

enum UserDefaultsKeys : String {
    case isLoggedIn
    case userDocumentID
    case userID
    case userFirstName
    case userLastName
}

extension UserDefaults{

    //MARK: Check Login
    func setLoggedIn(value: Bool) {
        // Change "false" to "value" if needing to unset the boolean
        set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }

    func isLoggedIn()-> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }

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
