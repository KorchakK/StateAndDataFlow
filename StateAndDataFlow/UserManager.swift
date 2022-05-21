//
//  UserManager.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 18.05.2022.
//

import Foundation

final class UserManager: ObservableObject {
    @Published var isRegistered = false
    var name = ""
}
