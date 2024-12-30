//
//  GameDetailViewModel.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 30/12/24.
//

import Foundation

class GameDetailViewModel: ObservableObject {
    @Published var game: Game
    
    init(game: Game) {
        self.game = game
    }
    
    func saveChanges() {
        GameDatabase.shared.updateGame(game)
    }
    
    func deleteGame() {
        var updatedGame = game
        updatedGame.isDeleted = true
        GameDatabase.shared.updateGame(updatedGame)
    }
}
