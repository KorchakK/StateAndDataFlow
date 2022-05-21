//
//  ContentView.swift
//  StateAndDataFlow
//
//  Created by Alexey Efimov on 18.05.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var user: UserManager
    @StateObject private var timer = TimeCounter()
    @State private var nameText = ""
    
    var body: some View {
        VStack {
            Text("Hi, \(nameText)")
                .font(.largeTitle)
                .padding(.top, 100)
                .onAppear(perform: updateName)
            Text("\(timer.counter)")
                .font(.largeTitle)
                .padding(.top, 200)
            Spacer()
            ButtonView(timer: timer)
            Spacer()
            LogOutButtonView(userManager: user)
        }
    }
    
    private func updateName() {
        if user.name == "" {
            user.name = StorageManager.shared.fetchNameValue()
        }
        nameText = user.name
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserManager())
    }
}

struct ButtonView: View {
    @ObservedObject var timer: TimeCounter
    
    var body: some View {
        Button(action: timer.startTimer) {
            Text(timer.buttonTitle)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(.red)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 4)
        }
    }
}

struct LogOutButtonView: View {
    @ObservedObject var userManager: UserManager
    
    var body: some View {
        Button(action: logoutButtonPressed) {
            Text("LogOut")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(.blue)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20).stroke(.black, lineWidth: 4)
        }
    }
    
    private func logoutButtonPressed() {
        userManager.isRegistered = false
        userManager.name = ""
        StorageManager.shared.setRegisteredValue(registered: false)
        StorageManager.shared.setNameValue(name: userManager.name)
    }
}
