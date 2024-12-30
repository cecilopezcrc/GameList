//
//  GameListViewConstants.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 30/12/24.
//

import Foundation

struct GameListViewConstants {
    struct sizes {
        static let searchBackgroundOpacity: CGFloat = 0.1
        static let searchCornerRadius: CGFloat = 8.0
        static let searchRadius: CGFloat = 5.0
        static let searchX: CGFloat = 0.0
        static let searchY: CGFloat = 3.0
        static let pickerCornerRadius: CGFloat = 8.0
        static let pickerRadius: CGFloat = 5.0
        static let pickerX: CGFloat = 0.0
        static let pickerY: CGFloat = 3.0
        static let pickerButtonFrame: CGFloat = 150.0
        static let pickerButtonCornerRadius: CGFloat = 8.0
        static let pickerButtonPadding: CGFloat = 10.0
        static let textGamePaddingVertical: CGFloat = 10.0
        static let textGameCornerRadius: CGFloat = 8.0
        static let textGameColorRadius: CGFloat = 3.0
        static let textGameColorX: CGFloat = 0.0
        static let textGameColorY: CGFloat = 2.0
    }
    
    struct strings {
        static let searchTitle: String = "Buscar"
        static let buttonPickerTitle: String = "Seleccionar género"
        static let buttonPickerUp: String = "chevron.up.circle.fill"
        static let buttonPickerDown: String = "chevron.down.circle.fill"
        static let pickerGenre: String = "Género"
        static let pickerDefaultAll: String = "Todos"
        static let imageGameName: String = "gamecontroller.fill"
        static let navigationTitle: String = "Videojuegos"
    }

}
