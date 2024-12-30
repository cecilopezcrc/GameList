//
//  GameListViewModel.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 30/12/24.
//

import Foundation
import SwiftUI

class GameListViewModel: ObservableObject {
    @Published var games: [Game] = []
    @Published var selectedCategory: String = ""
    @Published var searchQuery: String = ""

    var filteredGames: [Game] {
        var filtered = games
        
        if !selectedCategory.isEmpty {
            filtered = filtered.filter { game in
                guard let genre = game.genre else { return false }
                return genre.lowercased() == selectedCategory.lowercased()
            }
        }
        
        if !searchQuery.isEmpty {
            filtered = filtered.filter { game in
                game.title.lowercased().contains(searchQuery.lowercased())
            }
        }
        
        return filtered
    }


    func loadGames() {
        guard let url = URL(string: "https://www.freetogame.com/api/games") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                do {
                    let fetchedGames = try JSONDecoder().decode([Game].self, from: data)
                    DispatchQueue.main.async {
                        self.games = fetchedGames
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}
