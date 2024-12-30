//
//  DataBaseModel.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 29/12/24.
//

import Foundation

class GameDatabase {
    static let shared = GameDatabase()
    private let storageKey = "GameDatabase"
    
    private init() {}
    
    func saveGames(_ games: [Game]) {
        if let data = try? JSONEncoder().encode(games) {
            UserDefaults.standard.set(data, forKey: storageKey)
        }
    }
    
    func loadGames() -> [Game] {
        if let data = UserDefaults.standard.data(forKey: storageKey),
           let games = try? JSONDecoder().decode([Game].self, from: data) {
            return games
        }
        return []
    }
    
    func updateGame(_ game: Game) {
        var games = loadGames()
        if let index = games.firstIndex(where: { $0.id == game.id }) {
            games[index] = game
            saveGames(games)
        }
    }
}
