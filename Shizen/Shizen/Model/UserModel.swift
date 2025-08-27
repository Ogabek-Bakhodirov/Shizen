//
//  UserModel.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 30/11/24.
//

//To do:
//Award Manager also works with local storage - done
// leader board ishlashi uchun user poin va full name ni opshiy cloud storageda saqlaw kerak
//Quiz savollar:
// if offline -> dummy quiz question data
// if online -> ai based question: - done
//When loads ai based questions? - done
//quiz view ochilganda shimmer animation bulib turadi va quiz question data load bo'ladi

//Task add question and users answer to UserModel history
//Better solution for storing data (quizHistory) 

import Foundation

class UserModel: Codable {

    static let shared = UserModel.loadFromUserDefaults() ?? UserModel(userId: "",
                                                                      name: "",
                                                                      surname: "",
                                                                      number: "",
                                                                      age: 0,
                                                                      gender: .notSelected,
                                                                      country: "",
                                                                      preferences: [],
                                                                      focusSession: [FocusSession(id: UUID(), title: "Kunlik fokus rejimi", dailyScore: 0,
tractionHistory: [Calendar.current.date(byAdding: .day, value: -1, to: Date())!:1,Date():0,
                  Calendar.current.date(byAdding: .day, value: -3, to: Date())!:4,
                  Calendar.current.date(byAdding: .day, value: -4, to: Date())!:3,
                  Calendar.current.date(byAdding: .day, value: -5, to: Date())!:6,
                  Calendar.current.date(byAdding: .day, value: -6, to: Date())!:7,
                  Calendar.current.date(byAdding: .day, value: -9, to: Date())!:8,
                  Calendar.current.date(byAdding: .day, value: -11, to: Date())!:10,
                  Calendar.current.date(byAdding: .day, value: -13, to: Date())!:0,
                  Calendar.current.date(byAdding: .day, value: +13, to: Date())!:10])])

    private var userId: String
    private var name: String { didSet { saveToUserDefaults() } }
    private var surname: String { didSet { saveToUserDefaults() } }
    private var number: String { didSet { saveToUserDefaults() } }
    private var age: Int { didSet { saveToUserDefaults() } }
    private var gender: Gender { didSet { saveToUserDefaults() } }
    private var country: String { didSet { saveToUserDefaults() } }
    
    var focusSession: [FocusSession] {didSet {saveToUserDefaults()} }

    // Foydalanuvchi qiziqishlari
    var preferences: [String] { didSet { saveToUserDefaults() } }

    private init(userId: String,
                 name: String,
                 surname: String,
                 number: String,
                 age: Int,
                 gender: Gender,
                 country: String,
                 preferences: [String] = [],
                 focusSession: [FocusSession] = [])
    {

        self.userId = userId
        self.name = name
        self.surname = surname
        self.number = number
        self.age = age
        self.gender = gender
        self.country = country
        self.preferences = preferences
        self.focusSession = focusSession
    }

    // MARK: - UserDefaults Storage
    private func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(self) {
            UserDefaults.standard.set(encodedData, forKey: "UserModel")
        }
    }

    static private func loadFromUserDefaults() -> UserModel? {
        if let savedData = UserDefaults.standard.data(forKey: "UserModel") {
            let decoder = JSONDecoder()
            return try? decoder.decode(UserModel.self, from: savedData)
        }
        return nil
    }
      
    //MARK: - Get Full Name
    func getFullName() -> String { return self.name + " " + self.surname}

    // MARK: - Name
    func changeName(name: String) { self.name = name }
    func getName() -> String { return self.name }

    // MARK: - Surname
    func changeSurname(surname: String) { self.surname = surname }
    func getSurname() -> String { return self.surname }

    // MARK: - Number
    func changeNumber(number: String) { self.number = number }
    func getNumber() -> String { return self.number }

    // MARK: - Age
    func changeAge(age: Int) { self.age = age }
    func getAge() -> Int { return self.age }

    // MARK: - Country
    func changeCountry(country: String) { self.country = country }
    func getCountry() -> String { return self.country }

    // MARK: - Gender
    func changeGender(gender: Gender) { self.gender = gender }
    func getGender() -> Gender { return self.gender }

    // MARK: - Preferences
    func addPreferences(newPreference: [String]) { preferences += newPreference }
    
    func printAll() {
        print("userId: " + userId,
              "name: " + name,
              "surname: " + surname,
              "number: " + number,
              "age: \(age)",
              "gender: \(gender)",
              "country: " + country,
              "preferences: \(preferences)",
              "focusSession: \(focusSession)"
              )
    }

    enum Gender: String, Codable { case male, female, notSelected }
}


extension UserModel {
    /// Har kuni kechasi ishlatilishi kerak (masalan background fetch yoki app ochilganda)
    func checkAndUpdateDailySessions() {
        let today = Calendar.current.startOfDay(for: Date())

        for i in 0..<focusSession.count {
            let session = focusSession[i]
            
            if let lastDate = session.tractionHistory.keys.sorted().last {
                let lastDay = Calendar.current.startOfDay(for: lastDate)
                
                if lastDay < today {
                    if session.dailyScore > 0 {
//                        focusSession[i].totalScore += session.dailyScore
                        focusSession[i].tractionHistory[today] = session.dailyScore
                    } else {
                        focusSession[i].tractionHistory[today] = 0
                    }
                    
                    focusSession[i].dailyScore = 0
                }
            } else {
                focusSession[i].tractionHistory[today] = session.dailyScore
                focusSession[i].dailyScore = 0
            }
        }
    }
}


//    // MARK: - Conversation History
//    func addMessage(id: String, sender: SenderType, content: String, messageType: MessageType) {
//        let newMessage = Message(id: id, sender: sender, content: content, timestamp: Date(), messageType: messageType)
//
//        if sender == .user {
//            // Yangi xabarga asoslanib qiziqishlarni yangilash
//            let detectedPreferences = analyzeMessage(for: content)
//            if !detectedPreferences.isEmpty {
//                addPreferences(newPreference: detectedPreferences)
//            }
//        }
//
//    }

//    // MARK: - Detect Preferences
//    func analyzeMessage(for message: String) -> [String] {
//        let keywords = ["math", "science", "technology", "art", "history"]
//        var detectedPreferences: [String] = []
//
//        for keyword in keywords {
//            if message.lowercased().contains(keyword) {
//                detectedPreferences.append(keyword)
//            }
//        }
//        return detectedPreferences
//    }
    
    //MARK: - PrintAll
    



// Suhbatdagi xabar modeli
//struct Message: Codable {
//    var id: String
//    var sender: SenderType
//    var content: String
//    var timestamp: Date
//    var messageType: MessageType
//}

//enum SenderType: String, Codable { case user, ai}

//enum MessageType: String, Codable {case text, image, multipleChoice, other}


//MARK: - GPT ning takliflari
//1. Qiziqishlarni aniqlashni takomillashtirish:
//Sizning analyzeMessage(for:) metodida foydalanuvchining xabaridagi so'zlarni qidirib, ularga mos qiziqishlarni aniqlayapsiz. Bu metodni biroz takomillashtirish mumkin. Misol uchun, keywords ro'yxatini faqat matnli so'zlar bilan cheklamasdan, aniq mavzularni ham qo'shish mumkin.

//Qiziqishlarni avtomatik tahlil qilish: AI'ni foydalanuvchining tarixiy xabarlaridan foydalangan holda yanada samarali qilish uchun, vaqt o'tgan sayin yanada ilg'or algoritmlar qo'llanilishi mumkin.
//Ma'lumotlar sinxronizatsiyasi: Foydalanuvchi qiziqishlari va xabar tarixi Firebase yoki boshqa serverga yuborilishi mumkin, bu esa ma'lumotlarni saqlash va tahlil qilishni osonlashtiradi.
