//
//  Stats.swift
//  WordPlay
//
//  Created by Camila Gloria on 10/29/24.
//

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
