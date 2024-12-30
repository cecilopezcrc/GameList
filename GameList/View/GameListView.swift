//
//  GameListView.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 29/12/24.
//

import SwiftUI

struct GameListView: View {
    typealias ConstantSize = GameListViewConstants.sizes
    typealias ConstantString = GameListViewConstants.strings
    
    @ObservedObject var viewModel = GameListViewModel()
    @State private var showPicker = false
    @State private var localCategory: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField(ConstantString.searchTitle, text: $viewModel.searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(Color.blue.opacity(ConstantSize.searchBackgroundOpacity))
                    .cornerRadius(ConstantSize.searchCornerRadius)
                    .shadow(color: .blue, radius: ConstantSize.searchRadius, x: ConstantSize.searchX, y: ConstantSize.searchY)
                    .padding(.horizontal)

                Button(action: {
                    withAnimation {
                        showPicker.toggle()
                    }
                }) {
                    HStack {
                        Text(localCategory.isEmpty ? ConstantString.buttonPickerTitle : localCategory)
                            .foregroundColor(.white)
                            .font(.title3)
                        Spacer()
                        Image(systemName: showPicker ? ConstantString.buttonPickerUp : ConstantString.buttonPickerDown)
                            .foregroundColor(.white)
                            .font(.title2)
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(ConstantSize.pickerCornerRadius)
                    .shadow(color: .blue, radius: ConstantSize.pickerRadius, x: ConstantSize.pickerX, y: ConstantSize.pickerY)
                }

                if showPicker {
                    Picker(ConstantString.pickerGenre, selection: $localCategory) {
                        Text(ConstantString.pickerDefaultAll).tag("")
                        ForEach(viewModel.games.compactMap { $0.genre }.unique(), id: \.self) { genre in
                            Text(genre).tag(genre)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: ConstantSize.pickerButtonFrame)
                    .padding(.horizontal)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(ConstantSize.pickerButtonCornerRadius)
                    .transition(.move(edge: .top))
                    .padding(.bottom, ConstantSize.pickerButtonPadding)
                }

                List(viewModel.filteredGames) { game in
                    NavigationLink(destination: GameDetailView(
                        game: game,
                        onDelete: { gameToDelete in
                            deleteGame(gameToDelete)
                        },
                        onEdit: { updatedGame in
                            editGame(updatedGame)
                        }
                    )) {
                        HStack {
                            Image(systemName: ConstantString.imageGameName)
                                .foregroundColor(Color.blue)
                                .padding(.trailing)

                            Text(game.title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, ConstantSize.textGamePaddingVertical)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(ConstantSize.textGameCornerRadius)
                                .shadow(color: .gray, radius: ConstantSize.textGameColorRadius, x: ConstantSize.textGameColorX, y: ConstantSize.textGameColorY)
                        }
                        .padding(.horizontal)
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationTitle(ConstantString.navigationTitle)
            .onAppear {
                viewModel.loadGames()
            }
            .onChange(of: localCategory) { newCategory in
                viewModel.selectedCategory = newCategory
            }
        }
    }
    
    private func deleteGame(_ game: Game) {
        withAnimation {
            viewModel.games.removeAll { $0.id == game.id }
        }
    }
    
    private func editGame(_ updatedGame: Game) {
        if let index = viewModel.games.firstIndex(where: { $0.id == updatedGame.id }) {
            viewModel.games[index] = updatedGame
        }
    }
}

extension Array where Element: Equatable {
    func unique() -> [Element] {
        var uniqueItems: [Element] = []
        for item in self {
            if !uniqueItems.contains(item) {
                uniqueItems.append(item)
            }
        }
        return uniqueItems
    }
}
