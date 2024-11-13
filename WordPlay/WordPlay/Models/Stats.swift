//
//  Stats.swift
//  WordPlay
//
//  Created by Chenelle Matthews on 11/5/24.
//

import Foundation
import FirebaseFirestore

struct Stats: Codable, Identifiable {
    @DocumentID var id: String?
    var username: String
    var streak: Int
    var totalWon: Int
    var totalGames: Int
    var lastGameDate: Date
    var defaultSize: Int
}
