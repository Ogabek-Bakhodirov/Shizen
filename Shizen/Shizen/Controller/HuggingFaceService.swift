////
////  HuggingFaceService.swift
////  Focus
////
////  Created by Ogabek Bakhodirov on 29/11/24.
////
//
//import Foundation
//
//class HuggingFaceService {
//    func fetchResponse(for prompt: String, completion: @escaping (String?) -> Void) {
//        guard let url = URL(string: HUGGING_FACE_BASE_URL) else {
//            completion(nil)
//            print("Invalid URL")
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(HUGGING_FACE_API_KEY)", forHTTPHeaderField: "Authorization")
//        
//        // Create the request body for Hugging Face API
//        let requestBody: [String: Any] = [
//            "inputs": prompt
//        ]
//        
//        request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])
//
//        // Start the URL session task
//        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                completion(nil)
//                return
//            }
//
//            // Print the raw response (optional, for debugging purposes)
//            if let rawData = String(data: data, encoding: .utf8) {
//                print("Raw Response: \(rawData)")
//            }
//
//            // Parse the response
//            if let jsonResponse = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]],
//               let generatedText = jsonResponse.first?["generated_text"] as? String {
//                completion(generatedText.trimmingCharacters(in: .whitespacesAndNewlines))
//            } else {
//                print("Failed to parse response")
//                completion(nil)
//            }
//        }
//
//        task.resume()
//    }
//}
