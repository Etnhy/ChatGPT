//
//  ContentView.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 25.03.2023.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var chatMessage: [ChatMessage] = []
    @State var messageText: String = " "
    @State var cancellables = Set<AnyCancellable>()
    let openAIService = OpenAIService()
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatMessage, id: \.id) { message in
                        messageView(message: message)
                    }
                }
                .padding()
            }
            HStack {
                TextField("Enter a message", text: $messageText)
                    .padding()
                    .background(.gray.opacity(0.3))
                    .cornerRadius(12)
                
                Button {
                    sendMessage()
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

//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
        }
    }
    func sendMessage() {
        let myMEssage = ChatMessage(
            id: UUID().uuidString, content: messageText,
            dataCreated: Date(), sender: .me)
        chatMessage.append(myMEssage)
        openAIService.sendMessage(message: messageText).sink { completion in
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else { return }
            let gptMessage = ChatMessage(
                id: response.id, content: textResponse,
                dataCreated: Date(), sender: .gpt)
            chatMessage.append(gptMessage)
        }
        .store(in: &cancellables)
        messageText = " "
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
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
