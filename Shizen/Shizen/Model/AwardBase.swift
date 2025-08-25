//
//  AwardBase.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 16/03/25.
//

import UIKit

class AwardBase: Codable {
    static let shared = loadFromUserDefaults() ?? AwardBase()
    
    private var AWARDBASE: [AwardManagerEnum: Bool] = {
        var dict = [AwardManagerEnum: Bool]()
        for award in AwardManagerEnum.allCases {
            dict[award] = false
        }
        return dict
    }()
    
    private init(){
        saveToUserDefaults()
    }
    
    private func saveToUserDefaults() {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(self) {
            UserDefaults.standard.set(encodedData, forKey: "AwardBase")
        }
    }
    
    static private func loadFromUserDefaults() -> AwardBase? {
        if let savedData = UserDefaults.standard.data(forKey: "AwardBase") {
            let decoder = JSONDecoder()
            if let loadedInstance = try? decoder.decode(AwardBase.self, from: savedData) {
                var hasChanges = false
                
                // Ensure all new enum cases are added
                for award in AwardManagerEnum.allCases {
                    if loadedInstance.AWARDBASE[award] == nil {
                        loadedInstance.AWARDBASE[award] = false
                        hasChanges = true // Mark that we added a new value
                    }
                }
                
                // Save only if new values were added
                if hasChanges {
                    loadedInstance.saveToUserDefaults()
                }
                
                return loadedInstance
            }
        }
        return nil
    }
    
    func isAwardGranted(_ award: AwardManagerEnum) -> Bool {
        return AWARDBASE[award] ?? false
    }
    
    func grantAward(_ award: AwardManagerEnum) {
        AWARDBASE[award] = true
        print(AWARDBASE)
        saveToUserDefaults()
    }
    
    func getAwardBase() -> [AwardManagerEnum: Bool] {
        return AWARDBASE
    }
}


/////////////////////
enum AwardManagerEnum: String, Codable, CaseIterable {
    
    struct AwardStruct {
        var awardIcon: UIImage
        var awardTitle: String
        var awardDescription: String
    }
    
    case firstUsage
    case tenCorrectAnswer
    case twentyCorrectAnswer
    case fiftyCorrectAnswer
    case hundredCorrectAnswer
    case fiveMinInQuiz
    case tenMinInQuiz
    case twentyMinInQuiz
    case halfHourInQuiz
    case hourInQuiz
    
    var award: AwardStruct {
        switch self {
                
        case .firstUsage:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "Birinchi foydalanish",
                awardDescription: "Focus AI'dan foydalanganingiz uchun tabriklaymiz!"
            )
        case .tenCorrectAnswer:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "10 ta to‘g‘ri javob",
                awardDescription: "Ajoyib! Siz 10 ta to‘g‘ri javob berdingiz."
            )
        case .twentyCorrectAnswer:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "20 ta to‘g‘ri javob",
                awardDescription: "Siz Focus AI'da 20 ta savolga to‘g‘ri javob berdingiz!"
            )
        case .fiftyCorrectAnswer:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "50 ta to‘g‘ri javob",
                awardDescription: "Ajoyib! Siz 50 ta savolga to‘g‘ri javob berdingiz."
            )
        case .hundredCorrectAnswer:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "100 ta to‘g‘ri javob",
                awardDescription: "Siz haqiqiy bilimdon ekansiz! 100 ta to‘g‘ri javob berdingiz."
            )
        case .fiveMinInQuiz:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "5 daqiqa viktorinada",
                awardDescription: "Siz Focus AI viktorinasida 5 daqiqa o'tkazdingiz."
            )
        case .tenMinInQuiz:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "10 daqiqa viktorinada",
                awardDescription: "Focus AI'da bilim olishga vaqt ajratganingiz uchun rahmat!"
            )
        case .twentyMinInQuiz:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "20 daqiqa viktorinada",
                awardDescription: "Siz 20 daqiqa davomida viktorinada qatnashdingiz. Ajoyib!"
            )
        case .halfHourInQuiz:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "30 daqiqa viktorinada",
                awardDescription: "Focus AI yordamida bilim olish uchun 30 daqiqa vaqt sarfladingiz."
            )
        case .hourInQuiz:
            return AwardStruct(
                awardIcon: UIImage().getImage(.appLogo),
                awardTitle: "1 soat viktorinada",
                awardDescription: "Siz 1 soat davomida viktorinada qatnashdingiz! Bu haqiqiy fidoyilik!"
            )
        }
    }
}


