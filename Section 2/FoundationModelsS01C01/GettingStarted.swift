//
//  GettingStarted.swift
//  FoundationModelsS01C01
//
//  Created by DevTechie on 10/13/25.
//

import FoundationModels
import SwiftUI

struct GettingStarted: View {
    private var model = SystemLanguageModel.default
    @State private var generatedResponse: String = ""
    
    var body: some View {
        NavigationStack {
            Group {
                switch model.availability {
                case .available:
                    ScrollView {
                        Text(generatedResponse)
                    }
                    .padding()
                    
                case .unavailable(.deviceNotEligible):
                    UnavailableFeatureView(title: "Device Not Eligible", description: "This device doesn't support Apple Intelligence", systemImage: "exclamationmark.triangle")
                   
                case .unavailable(.appleIntelligenceNotEnabled):
                    UnavailableFeatureView(title: "Apple Intelligence Disabled", description: "Please enable Apple Intelligence in Settings to use this feature.", systemImage: "gear")
                    
                case .unavailable(.modelNotReady):
                    UnavailableFeatureView(title: "Model Not Ready", description: "The intelligence feautres are being prepared. Please try again shortly.", systemImage: "clock.arrow.circlepath")
                case .unavailable:
                    UnavailableFeatureView(title: "Feature Unavailable", description: "This feature is currently unavailable. Reasons unknown.", systemImage: "questionmark.circle")
                }
                
            }
            .onAppear {
                performGeneration()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Generate") {
                        performGeneration()
                    }
                }
            }
        }
    }
    
    func performGeneration() {
        Task {
            do {
               generatedResponse = try await generateResponse(for: "coffee bean")
            } catch {
                generatedResponse = error.localizedDescription
            }
        }
    }
    
    func generateResponse(for text: String) async throws -> String {
        let instructions = """
            You are a friendly kids story writer. Write 100 words on given topic.
            """
        let session = LanguageModelSession(instructions: instructions)
        let options = GenerationOptions(temperature: 0.1 )
        let prompt = "Write story on \(text)"
        let reponse = try await session.respond(to: prompt, options: options)
        return reponse.content
    }
}


struct UnavailableFeatureView: View {
    let title: String
    let description: String
    let systemImage: String
    
    var body: some View {
        ContentUnavailableView(title, systemImage: systemImage, description: Text(description))
    }
}
