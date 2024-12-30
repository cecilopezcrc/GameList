//
//  SplashViewModel.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 30/12/24.
//

import Foundation

class SplashViewModel: ObservableObject {
    @Published var isLoaded = false
    
    func loadGames() {
        guard let url = URL(string: "https://www.freetogame.com/api/games") else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                do {
                    let games = try JSONDecoder().decode([Game].self, from: data)
                    GameDatabase.shared.saveGames(games)
                    DispatchQueue.main.async {
                        self.isLoaded = true 
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

