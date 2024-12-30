//
//  GameDetailView.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 29/12/24.
//

import SwiftUI

struct GameDetailView: View {
    typealias ConstantSize = GameDetailViewConstants.sizes
    var game: Game
    
    var body: some View {
        VStack(spacing: ConstantSize.vStackSpacing) {

            Text(game.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .padding(.top, ConstantSize.gameTilePadding)
            
            Text("Género: \(game.genre ?? "N/A")")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.horizontal)
            
            Text("Descripción: \(game.description ?? "N/A")")
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            
            Button(action: {
            }) {
                Text("Editar videojuego")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(ConstantSize.buttonEdithCornerRadius)
                    .shadow(radius: ConstantSize.buttonEdithShadowRadius)
            }
            .padding(.horizontal)
            
            Button(action: {
            }) {
                Text("Eliminar videojuego")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(ConstantSize.buttonEliminateCornerRadius)
                    .shadow(radius: ConstantSize.buttonEliminateShadowRadius)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding(.horizontal)
        .navigationTitle(game.title)
        .background(LinearGradient(gradient: Gradient(colors: [Color.purple.opacity(ConstantSize.backgroundPurpleOpacity), Color.blue]), startPoint: .top, endPoint: .bottom))
        .cornerRadius(ConstantSize.backgroundCornerRadius)
        .shadow(radius: ConstantSize.backgroundShadowRadius)
    }
}
