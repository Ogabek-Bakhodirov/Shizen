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
                                                                      point: 0,
                                                                      quizUsageTimeMinute: 1.0,
                                                                      preferences: [],
                                                                      conversationHistory: [],
                                                                      lastInteractionDate: Date(),
                                                                      quizHistory: [])

    private var userId: String
    private var name: String { didSet { saveToUserDefaults() } }
    private var surname: String { didSet { saveToUserDefaults() } }
    private var number: String { didSet { saveToUserDefaults() } }
    private var age: Int { didSet { saveToUserDefaults() } }
    private var gender: Gender { didSet { saveToUserDefaults() } }
    private var country: String { didSet { saveToUserDefaults() } }
    private var point: Int { didSet { saveToUserDefaults() } }
    private var quizUsageTimeMinute: Double { didSet { saveToUserDefaults() } }
    private var quizHistory: [String] {didSet {saveToUserDefaults()}}

    // Foydalanuvchi qiziqishlari
    var preferences: [String] { didSet { saveToUserDefaults() } }
    // Foydalanuvchi shaxsiy xabarlar tarixi
    var conversationHistory: [Message] { didSet { saveToUserDefaults() } }
    // Oxirgi suhbat qachon bo'lgan
    private var lastInteractionDate: Date? { didSet { saveToUserDefaults() } }

    private init(userId: String,
                 name: String,
                 surname: String,
                 number: String,
                 age: Int,
                 gender: Gender,
                 country: String,
                 point: Int,
                 quizUsageTimeMinute: Double,
                 preferences: [String] = [],
                 conversationHistory: [Message] = [],
                 lastInteractionDate: Date?,
                 quizHistory: [String] = [])
    {

        self.userId = userId
        self.name = name
        self.surname = surname
        self.number = number
        self.age = age
        self.gender = gender
        self.country = country
        self.point = point
        self.quizUsageTimeMinute = quizUsageTimeMinute
        self.preferences = preferences
        self.conversationHistory = conversationHistory
        self.lastInteractionDate = lastInteractionDate
        self.quizHistory = quizHistory
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
    
    //MARK: - Quiz history
    func getQuizHistory() -> [String] { return self.quizHistory }
    func updateQuizHistory(quiz: [String]) { self.quizHistory.append(contentsOf: quiz) }
    
    //MARK: - Get Full Name
    func getFullName() -> String { return self.name + " " + self.surname}
    
    //MARK: - Usage Time
    func getQuizUsageTimeInMin() -> Double {return self.quizUsageTimeMinute}
    func changeQuizUsageTime(time: Double) { self.quizUsageTimeMinute += (time / 60)}

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

    // MARK: - Points
    func addPoints() { self.point += 1 }
    func getPoints() -> Int { return self.point }

    // MARK: - Preferences
    func addPreferences(newPreference: [String]) { preferences += newPreference }

    // MARK: - Conversation History
    func addMessage(id: String, sender: SenderType, content: String, messageType: MessageType) {
        let newMessage = Message(id: id, sender: sender, content: content, timestamp: Date(), messageType: messageType)
        conversationHistory.append(newMessage)

        if sender == .user {
            // Yangi xabarga asoslanib qiziqishlarni yangilash
            let detectedPreferences = analyzeMessage(for: content)
            if !detectedPreferences.isEmpty {
                addPreferences(newPreference: detectedPreferences)
            }
        }

        lastInteractionDate = Date()
    }

    // MARK: - Detect Preferences
    func analyzeMessage(for message: String) -> [String] {
        let keywords = ["math", "science", "technology", "art", "history"]
        var detectedPreferences: [String] = []

        for keyword in keywords {
            if message.lowercased().contains(keyword) {
                detectedPreferences.append(keyword)
            }
        }
        return detectedPreferences
    }
    
    //MARK: - PrintAll
    
    func printAll() {
        print("userId: " + userId,
              "name: " + name,
              "surname: " + surname,
              "number: " + number,
              "age: \(age)",
              "gender: \(gender)",
              "country: " + country,
              "point: \(point)",
              "quizUsageTimeMinute: \(quizUsageTimeMinute)",
              "preferences: \(preferences)",
              "conversationHistory: \(conversationHistory)",
              "lastInteractionDate: \(String(describing: lastInteractionDate))",
              "quizHistory: \(quizHistory)")
    }

    enum Gender: String, Codable { case male, female, notSelected }
}


// Suhbatdagi xabar modeli
struct Message: Codable {
    var id: String
    var sender: SenderType
    var content: String
    var timestamp: Date
    var messageType: MessageType
}

enum SenderType: String, Codable { case user, ai}

enum MessageType: String, Codable {case text, image, multipleChoice, other}


//MARK: - GPT ning takliflari
//1. Qiziqishlarni aniqlashni takomillashtirish:
//Sizning analyzeMessage(for:) metodida foydalanuvchining xabaridagi so'zlarni qidirib, ularga mos qiziqishlarni aniqlayapsiz. Bu metodni biroz takomillashtirish mumkin. Misol uchun, keywords ro'yxatini faqat matnli so'zlar bilan cheklamasdan, aniq mavzularni ham qo'shish mumkin.

//Qiziqishlarni avtomatik tahlil qilish: AI'ni foydalanuvchining tarixiy xabarlaridan foydalangan holda yanada samarali qilish uchun, vaqt o'tgan sayin yanada ilg'or algoritmlar qo'llanilishi mumkin.
//Ma'lumotlar sinxronizatsiyasi: Foydalanuvchi qiziqishlari va xabar tarixi Firebase yoki boshqa serverga yuborilishi mumkin, bu esa ma'lumotlarni saqlash va tahlil qilishni osonlashtiradi.
