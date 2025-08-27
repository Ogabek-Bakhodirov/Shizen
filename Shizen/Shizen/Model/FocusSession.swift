//
//  FocusSession.swift
//  Shizen
//
//  Created by Ogabek Bakhodirov on 26/08/25.
//

import Foundation

struct FocusSession: Identifiable, Codable {

    var id: UUID
    var title: String
    var dailyScore: Int
    var tractionHistory: [Date : Int]
}


