////
////  OpenAIService.swift
////  Focus
////
////  Created by Ogabek Bakhodirov on 28/11/24.
////
//
//import UIKit
//
//class OpenAIService {
//    func fetchResponse(for prompt: String, completion: @escaping (String?) -> Void) {
//        guard let url = URL(string: OPENAI_BASE_URL) else {
//            completion(nil)
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(OPENAI_API_KEY)", forHTTPHeaderField: "Authorization")
//        
//        
//        // Create the request body for the chat model
//        let requestBody: [String: Any] = [
//            "model": "gpt-3.5-turbo",
//            "messages": [
//                ["role": "system", "content": "You are a helpful assistant."],
//                ["role": "user", "content": prompt]
//            ],
//            "max_tokens": 150,
//            "temperature": 0.7
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
//        
//
//        // Start the URL session task
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//                return
//            }
//
//            if let rawData = String(data: data, encoding: .utf8) {
//                print("Raw Response: \(rawData)")
//            }
//
//            // Parse the response
//            if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
//               let choices = jsonResponse["choices"] as? [[String: Any]],
//               let message = choices.first?["message"] as? [String: Any],
//               let content = message["content"] as? String {
//                
//                completion(content.trimmingCharacters(in: .whitespacesAndNewlines))
//            } else {
//                print("Failed to parse response")
//                completion(nil)
//            }
//        }
//
//        task.resume()
//    }
//}
