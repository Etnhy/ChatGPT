//
//  ContentView.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 25.03.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var vm: ChatGPTViewModel
    
    var body: some View {
        ZStack {

            VStack {
                Button {
                    vm.isApiKey = false
                    vm.chatMessage = []
                } label: {
                    HStack {
                        Image(systemName: "arrowshape.turn.up.backward.fill")
                        Text("Back to welcome view")
                            .bold()
                            
                        Spacer()
                    }.foregroundColor(.white)
                        .padding()
                }
                
                ScrollView {
                    LazyVStack {
                        ForEach(vm.chatMessage, id: \.id) { message in
                            messageView(message: message)
                        }
                    }
                    .padding()
                }
                HStack {
                    TextField("Enter a message", text: $vm.messageText)
                        .padding()
                        .background(.gray.opacity(0.8))
                        .cornerRadius(12)
                    Button {
                        vm.sendMessage()
                    } label: {
                        Text("Send")
                            .foregroundColor(.white)
                            .padding()
                            .background(.green.opacity(0.7))
                            .cornerRadius(12)
                    }
                }
                .padding()
            }
            
        }
        .background(
            Image("openai")
                    .resizable()
                    .aspectRatio(1 / 1, contentMode: .fill)
                    .frame(width: 600, height: 600)
                    .blur(radius: 15))
        .background(.black, ignoresSafeAreaEdges: .all)
    }
    
    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .me { Spacer() }
            Text(message.content)
                .foregroundColor(message.sender == .me ? .white : .white)
                .padding()
                .background(message.sender == .me ? MessageColors.meColor : MessageColors.gptColor.opacity(0.7))
                .cornerRadius(16)
            if message.sender == .gpt { Spacer() }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ChatGPTViewModel())
    }
}


enum MessageColors {
    static let meColor = Color(red: 0.39, green: 0.35, blue: 0.33)
    static let gptColor = Color(red: 0.15, green: 0.16, blue: 0.17)
}
