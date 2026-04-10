//
//  ContentView.swift
//  FoundationModelsS01C01
//
//  Created by DevTechie on 10/12/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("DevTechie.com")
            .font(.largeTitle)
    }
}


#Preview {
    ContentView()
}

import FoundationModels
import Playgrounds

#Playground {
    Task {
        do {
            let session = try LanguageModelSession()
            //let response = try await session.streamResponse(to: "write 100 words about DevTechie.com")
            
//            for try await partialResponse in response {
//                print(partialResponse.content)
//            }
            
            let response = try await session.respond(to: "write swiftui VStack example?")
            print(response.content)
            
        } catch {
            print("Error: \(error)")
        }
    }
}
