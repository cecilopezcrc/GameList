//
//  GameModel.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 29/12/24.
//

import Foundation

struct Game: Identifiable, Codable {
    let id: Int
    var title: String
    var genre: String?
    var description: String?
    var imageURL: String?
    var isDeleted: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case genre
        case description = "short_description"
    }
}
