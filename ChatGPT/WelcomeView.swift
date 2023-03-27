//
//  WelcomeView.swift
//  ChatGPT
//
//  Created by Евгений Маглена on 27.03.2023.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var vm: ChatGPTViewModel
    
    var body: some View {
            VStack {
                Image("openai2")
                    .resizable()
                    .frame(width: 300, height: 80)
                    .foregroundColor(.black)
                    .padding()

                HStack {
                    TextField("Enter OpenAI key", text: $vm.apiKey)
                        .padding()
                        .background(.gray.opacity(0.3))
                        .cornerRadius(12)
                    Button {
                        vm.setApiKey()
                    } label: {
                        Text("Set")
                            .foregroundColor(.white)
                            .padding()
                            .background(.black)
                            .cornerRadius(12)
                    }
                }                    
            }
            .padding()
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(ChatGPTViewModel())
    }
}
