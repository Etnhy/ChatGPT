//
//  ChatGPTApp.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 25.03.2023.
//

import SwiftUI

@main
struct ChatGPTApp: App {
    @ObservedObject var vm = ChatGPTViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
