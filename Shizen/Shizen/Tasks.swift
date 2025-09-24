//
//  Tasks.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 29/01/25.
//

//import Foundation

//import ManagedSettings
//
//var SELECTED_APP_TOKEN: ApplicationToken? {
//    didSet {
//        if let token = SELECTED_APP_TOKEN {
//            print("New token assigned: \(token) ------------")
//        } else {
//            print("Token is now nil")
//        }
//    }
//}
//enum APIKey{
//    static var `default`: String {
//        guard let filePath = Bundle.main.path(forResource: "GenerativeAI-Info", ofType: "plist")
//        else { fatalError("Couldn't find file 'GenerativeAI-Info-plist'.") }
//        let plist = NSDictionary(contentsOfFile: filePath)
//        guard let value = plist?.object(forKey: "API_KEY") as? String else {
//            fatalError ("Couldn't find key 'API_KEY' in 'GenerativeAI-Info.plist' .")}
//        if value.starts(with: "_"){
//            fatalError("Follow the instructions at https://ai.google.dev/tutorials/setup to get an API key.")
//        }
//        return value
//    }
//}



//import GoogleGenerativeAI
//
//class GeminiApiRequest {
//    
//
//    let config = GenerationConfig(
//      temperature: 1,
//      topP: 0.95,
//      topK: 40,
//      maxOutputTokens: 8192,
//      responseMIMEType: "text/plain"
//    )
//
//    // Don't check your API key into source control!
//    guard; let apiKey = ProcessInfo.processInfo.environment["GEMINI_API_KEY"] else {
//      fatalError("Add GEMINI_API_KEY as an Environment Variable in your app's scheme.")
//    }
//
//    let model = GenerativeModel(
//      name: "gemini-2.0-flash",
//      apiKey: apiKey,
//      generationConfig: config
//    )
//
//    let chat = model.startChat(history: [
//
//    ])
//
//    Task {
//      do {
//        let message = "INSERT_INPUT_HERE"
//        let response = try await chat.sendMessage(message)
//        print(response.text ?? "No response received")
//      } catch {
//        print(error)
//      }
//    }
//}



//Prosta kirib chiqqanda kalendarda qizil bolishi 
