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
        ZStack {
            Color.black
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .center) {
                    Image("openai")
                        .resizable()
                        .frame(width: 120, height: 120)
                    VStack(alignment: .leading) {
                        Text("Open AI")
                            .font(.system(size: 60))
                            .bold()
                        Text("Chat GPT")
                            .font(.system(size: 30))
                            .bold()
                    }
                    .foregroundColor(.white)
                }
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
                                .background(.green.opacity(0.7))
                                .cornerRadius(12)
                        }
                    }
            }
                .padding()
        }
//        .background(Color.black, ignoresSafeAreaEdges: .all)
    }
    
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(ChatGPTViewModel())
    }
}
