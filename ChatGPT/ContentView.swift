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
        VStack {
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
                    .background(.gray.opacity(0.3))
                    .cornerRadius(12)
                
                Button {
                    vm.sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(12)
                }

            }
            .padding()
        }

    }
    func messageView(message: ChatMessage) -> some View {
        HStack {
            if message.sender == .me { Spacer() }
            Text(message.content)
                .foregroundColor(message.sender == .me ? .white : .black)
                .padding()
                .background(message.sender == .me ? .blue : .gray.opacity(0.2))
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


struct ChatMessage {
    let id: String
    let content: String
    let dataCreated: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case gpt
}
extension ChatMessage {
    static let sampleMessage = [
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dataCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dataCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dataCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dataCreated: Date(), sender: .gpt),]
}
