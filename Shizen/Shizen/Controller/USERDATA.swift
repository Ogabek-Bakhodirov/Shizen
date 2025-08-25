//
//  USERDATA.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 09/03/25.
//

//import Foundation
//
//struct User: Codable {
//    var id: Int
//    var username: String
//    var email: String
//}
//
//class UserManager {
//    static let shared = UserManager()
//
//    private let userDefaults = UserDefaults.standard
//    private let userKey = "savedUser"
//
//    var currentUser: User? {
//        get {
//            if let data = userDefaults.data(forKey: userKey) {
//                return try? JSONDecoder().decode(User.self, from: data)
//            }
//            return nil
//        }
//        set {
//            if let encoded = try? JSONEncoder().encode(newValue) {
//                userDefaults.set(encoded, forKey: userKey)
//            }
//        }
//    }
//
//    private init() {}
//}
//
//// Usage Example:
//UserManager.shared.currentUser = User(id: 1, username: "JohnDoe", email: "john@example.com")
//print(UserManager.shared.currentUser?.username ?? "No User") // Output: JohnDoe
