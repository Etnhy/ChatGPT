//
//  Constants.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 27.03.2023.
//

import Foundation

// MARK: - Nested types

 enum Constants {
     static let openAIAPIkey: String = {
         guard let key = Bundle.main.object(forInfoDictionaryKey: "OPENAI_KEY") as? String else {
             fatalError(" API KEY ERROR")
         }
         return "\(key)"
     }()
}
