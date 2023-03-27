//
//  OpenAIService.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 27.03.2023.
//

import Foundation
import Alamofire
import Combine

class OpenAIService {
   private let baseURL = "https://api.openai.com/v1/" //completions
    
    
    public func sendMessage(apiKey: String,message: String)-> AnyPublisher<OpenAICompletionsResponse, Error> {
        let body = OpenAICompletionBody(model: "text-davinci-003", prompt: message, temperature: 0.7, max_tokens: 3000)
        let headers: HTTPHeaders = [
            "Authorization":"Bearer \(apiKey)"]
        return Future {[weak self] promise in
            guard let self = self else { return }
            AF.request(self.baseURL + "completions", method: .post, parameters: body, encoder: .json(), headers: headers).responseDecodable(of:OpenAICompletionsResponse.self) { response in

                switch response.result {
                    
                case .success(let result):
                    promise(.success(result))
                case .failure(let err):
                    promise(.failure(err))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

struct OpenAICompletionBody: Encodable {
    let model: String
    let prompt: String
    let temperature: Float?
    let max_tokens: Int
}
struct OpenAICompletionsResponse: Decodable {
    let id: String
    let choices: [CompletionOptionsChoice]
}

struct CompletionOptionsChoice: Decodable {
    let text: String
}
