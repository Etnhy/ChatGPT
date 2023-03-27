//
//  ChatMessage.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 27.03.2023.
//

import Foundation

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

// mock
extension ChatMessage {
    static let sampleMessage = [
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dataCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dataCreated: Date(), sender: .gpt),
        ChatMessage(id: UUID().uuidString, content: "Sample message from me", dataCreated: Date(), sender: .me),
        ChatMessage(id: UUID().uuidString, content: "Sample message from gpt", dataCreated: Date(), sender: .gpt),]
}
