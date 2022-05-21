//
//  RegisterView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 18.05.2022.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject private var userManger: UserManager
    
    @State private var name = ""
    @State private var notCorrectName = true
    @State private var counterColor: Color = .red
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                TextField("Enter your name...", text: $name)
                    .multilineTextAlignment(.center)
                    .onChange(of: name) { newValue in
                        checkCorrectName(name: newValue)
                    }
                Text("\(name.count)")
                    .foregroundColor(counterColor)
            }
            Button(action: registerUser) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("OK")
                }
            }
                .disabled(notCorrectName)
        }
            .padding(30)
    }
    
    private func registerUser() {
        userManger.name = name
        userManger.isRegistered.toggle()
        StorageManager.shared.setRegisteredValue(registered: true)
    }
    
    private func checkCorrectName(name: String) {
        if name.count > 2 {
            notCorrectName = false
            counterColor = .green
        } else {
            notCorrectName = true
            counterColor = .red
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
            .environmentObject(UserManager())
    }
}
