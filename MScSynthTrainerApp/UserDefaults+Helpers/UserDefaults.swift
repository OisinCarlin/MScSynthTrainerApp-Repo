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
    
//    case q1result
//    case q2result
//    case q3result
//    case q4result
//    case q5result
//    case q6result
//    case q7result
//    case q8result
//    case q9result
//    case q10result
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
    
    
    
    
    // Quiz results 
//    
//    func setQ1Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q1result.rawValue)
//        synchronize()
//    }
//    
//    func getQ1Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q1result.rawValue)
//    }
//    
//    func setQ2Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q2result.rawValue)
//        synchronize()
//    }
//    
//    func getQ2Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q2result.rawValue)
//    }
//    
//    func setQ3Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q3result.rawValue)
//        synchronize()
//    }
//    
//    func getQ3Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q3result.rawValue)
//    }
//    
//    func setQ4Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q4result.rawValue)
//        synchronize()
//    }
//    
//    func getQ4Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q4result.rawValue)
//    }
//    
//    func setQ5Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q5result.rawValue)
//        synchronize()
//    }
//    
//    func getQ5Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q5result.rawValue)
//    }
//    
//    func setQ6Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q6result.rawValue)
//        synchronize()
//    }
//    
//    func getQ6Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q6result.rawValue)
//    }
//    
//    func setQ7Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q7result.rawValue)
//        synchronize()
//    }
//    
//    func getQ7Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q7result.rawValue)
//    }
//    
//    func setQ8Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q8result.rawValue)
//        synchronize()
//    }
//    
//    func getQ8Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q8result.rawValue)
//    }
//    
//    func setQ9Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q9result.rawValue)
//        synchronize()
//    }
//    
//    func getQ9Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q9result.rawValue)
//    }
//    
//    func setQ10Result(value : Int){
//        set(value, forKey: UserDefaultsKeys.q10result.rawValue)
//        synchronize()
//    }
//    
//    func getQ10Result() -> Int{
//        return integer(forKey: UserDefaultsKeys.q10result.rawValue)
//    }
//    
//    
//    
    

    
    
}
