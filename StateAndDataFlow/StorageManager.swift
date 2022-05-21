//
//  UserRegister.swift
//  StateAndDataFlow
//
//  Created by Konstantin Korchak on 21.05.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private init() {}
    
    func setRegisteredValue(registered: Bool) {
        UserDefaults.standard.set(registered, forKey: "registered")
    }
    
    func setNameValue(name: String) {
        UserDefaults.standard.set(name, forKey: "name")
    }
    
    func fetchRegisteredValue() -> Bool {
        let registered = UserDefaults.standard.value(forKey: "registered")
        guard let registered = registered as? Bool else { return false }
        return registered
    }
    
    func fetchNameValue() -> String {
        let name = UserDefaults.standard.value(forKey: "name")
        guard let name = name as? String else { return ""}
        return name
    }
    
}
