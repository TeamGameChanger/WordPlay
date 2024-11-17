//
//  Dictionary.swift
//  WordPlay
//
//  Created by Camila Gloria on 11/5/24.
//

import Foundation

// singleton instance that lazily loads the 5 letter and 6 letter word lists for duration of app lifetime
class WordList {
    static let shared = WordList()
    private(set) var fiveLetterWords: Set<String> = []
    private(set) var sixLetterWords: Set<String> = []
    private var initialized = false
    
    func initialize() {
        guard !initialized else { return }
        
        let filePath5 = Bundle.main.path(forResource: "words_5", ofType: "txt")
        let filePath6 = Bundle.main.path(forResource: "words_6", ofType: "txt")
        
        if let filePath5, let filePath6 {
            do {
                var fileContents = try String(contentsOfFile: filePath5, encoding: .utf8)
                fiveLetterWords = Set(fileContents.split(separator: "\n").map { String($0) })
                
                fileContents = try String(contentsOfFile: filePath6, encoding: .utf8)
                sixLetterWords = Set(fileContents.split(separator: "\n").map { String($0) })
                
                initialized = true
            } catch {
                print("Error loading file: \(error)")
            }
        } else {
            print("File not found.")
        }
    }
}
