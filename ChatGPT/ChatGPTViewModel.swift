//
//  ChatGPTViewModel.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 27.03.2023.
//

import Foundation
import Combine

class ChatGPTViewModel: ObservableObject {
    @Published var chatMessage: [ChatMessage] = []
    @Published var cancellables = Set<AnyCancellable>()
    @Published var messageText: String = " "
    @Published var isApiKey: Bool = false
    @Published var apiKey: String = " "

    private let openAIService = OpenAIService()
    
    
    
   public func sendMessage() {
        let myMEssage = ChatMessage(
            id: UUID().uuidString, content: messageText,
            dataCreated: Date(), sender: .me)
        chatMessage.append(myMEssage)
        openAIService.sendMessage(apiKey: apiKey,message: messageText).sink { completion in
        } receiveValue: { response in
            guard let textResponse = response.choices.first?.text.trimmingCharacters(
                in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else { return }
            let gptMessage = ChatMessage(
                id: response.id, content: textResponse,
                dataCreated: Date(), sender: .gpt)
            print(gptMessage)
            self.chatMessage.append(gptMessage)
        }
        .store(in: &cancellables)
        messageText = " "
    }
    
    public func setApiKey() {
        if apiKey != " " && !apiKey.isEmpty {
            isApiKey = true
        }
        print(apiKey)
    }
    
}
