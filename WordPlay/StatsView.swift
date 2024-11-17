//
//  StatsView.swift
//  WordPlay
//
//  Created by Chenelle Matthews on 11/5/2024.
//

import SwiftUI

struct StatsView: View {
    @State private var stats: Stats? = nil
    @State private var isLoading = true
    
    private let firestoreManager = FirestoreManager()
    private let username: String
    
    init(username: String) {
        self.username = username
    }
    
    var body: some View {
        VStack(spacing: 20) {
            if isLoading {
                ProgressView("Loading...")
            } else if let stats = stats {
                Text("Player Stats")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top)
                
                VStack(alignment: .leading, spacing: 15) {
                    StatsRow(title: "Username", value: stats.username)
                    StatsRow(title: "Current Streak", value: "\(stats.streak) days")
                    StatsRow(title: "Total Wins", value: "\(stats.totalWon)")
                    StatsRow(title: "Total Games", value: "\(stats.totalGames)")
                    StatsRow(title: "Last Game", value: formattedDate(stats.lastGameDate))
                    StatsRow(title: "Default Size", value: "\(stats.defaultSize)")
                }
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(12)
                .shadow(radius: 5)
            } else {
                Text("No data available")
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.clear)
        .onAppear {
            fetchStats()
        }
    }
    
    private func fetchStats() {
        firestoreManager.fetchStats(forUsername: username) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedStats):
                    self.stats = fetchedStats
                case .failure(let error):
                    print("Error fetching stats: \(error.localizedDescription)")
                }
                self.isLoading = false
            }
        }
    }
    
    // Helper function to format date
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }
}

struct StatsRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title + ":")
                .font(.headline)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}

#Preview {
    StatsView(username: "PlayerOne")
}
