//
//  FirestoreManager.swift
//  WordPlay
//
//  Created by Chenelle Matthews on 11/7/2024.
//

import Foundation
import FirebaseFirestore

class FirestoreManager {
    private let db = Firestore.firestore()
    private let collectionName = "userStats"
    
    // Save Stats data to Firestore
    func saveStats(_ stats: Stats, completion: @escaping (Result<Void, Error>) -> Void) {
        do {
            try db.collection(collectionName).document(stats.username).setData(from: stats)
            completion(.success(()))
        } catch let error {
            completion(.failure(error))
        }
    }
    
    // Fetch Stats data from Firestore
    func fetchStats(forUsername username: String, completion: @escaping (Result<Stats, Error>) -> Void) {
        db.collection(collectionName).document(username).getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if let document = document, document.exists {
                do {
                    let stats = try document.data(as: Stats.self)
                    completion(.success(stats))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found"])))
            }
        }
    }
    
    // Update existing Stats data in Firestore
    func updateStats(_ stats: Stats, completion: @escaping (Result<Void, Error>) -> Void) {
        let docRef = db.collection(collectionName).document(stats.username)
        docRef.getDocument { document, error in
            if let error = error {
                completion(.failure(error))
            } else if document != nil {
                do {
                    try docRef.setData(from: stats, merge: true) // merge true keeps other fields unchanged
                    completion(.success(()))
                } catch let error {
                    completion(.failure(error))
                }
            } else {
                completion(.failure(NSError(domain: "", code: 404, userInfo: [NSLocalizedDescriptionKey: "Document not found"])))
            }
        }
    }
}
