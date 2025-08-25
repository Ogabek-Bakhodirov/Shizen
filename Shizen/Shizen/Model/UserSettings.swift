//
//  UserSettings.swift
//  Focus AI
//
//  Created by Ogabek Bakhodirov on 14/03/25.
//

// Foydalanuvchi sozlamalari modeli

import Foundation

class UserSettings {
    
    static let shared = UserSettings(language: .uzb, themeMode: .light)
    
    private var language: Language
    private var themeMode: ThemeMode// AI foydalanuvchi ma'lumotlaridan foydalansinmi
    
    private init(language: Language, themeMode: ThemeMode) {
        self.language = language
        self.themeMode = themeMode
    }
    
    func getLanguage() -> Language {
        return self.language
    }
    
    func changeLanguage(language: Language) {
        self.language = language
    }
    
    func getThemeMode() -> ThemeMode{
        self.themeMode
    }
    
    func changeThemeMode(themeMode: ThemeMode){
        self.themeMode = themeMode
    }
    
    
    //MARK: - Language
    enum Language: String, Codable {
        case uzb, rus, eng
    }

    //MARK: - ThemeMode
    enum ThemeMode: String, Codable {
        case light, dark
    }
}
