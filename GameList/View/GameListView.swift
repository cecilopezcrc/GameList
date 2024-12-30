//
//  GameListView.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 29/12/24.
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var viewModel = GameListViewModel()
    @State private var showPicker = false
    @State private var localCategory: String = ""
    var body: some View {
        NavigationView {
            VStack {
                TextField("Buscar", text: $viewModel.searchQuery)
                    .textFieldStyle(PlainTextFieldStyle())
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(8)
                    .shadow(color: .blue, radius: 5, x: 0, y: 3)
                    .padding(.horizontal)

                Button(action: {
                    withAnimation {
                        showPicker.toggle()
                    }
                }) {
                    HStack {
                        Text(localCategory.isEmpty ? "Seleccionar género" : localCategory)
                            .foregroundColor(.white)
                            .font(.title3)
                        Spacer()
                        Image(systemName: showPicker ? "chevron.up.circle.fill" : "chevron.down.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(8)
                    .shadow(color: .blue, radius: 5, x: 0, y: 3)
                }

                if showPicker {
                    Picker("Género", selection: $localCategory) {
                        Text("Todos").tag("")
                        ForEach(viewModel.games.compactMap { $0.genre }.unique(), id: \.self) { genre in
                            Text(genre).tag(genre)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 150)
                    .padding(.horizontal)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(8)
                    .transition(.move(edge: .top))
                    .padding(.bottom, 10)
                }

                List(viewModel.filteredGames) { game in
                    NavigationLink(destination: GameDetailView(game: game)) {
                        HStack {
                            Image(systemName: "gamecontroller.fill")
                                .foregroundColor(Color.blue)
                                .padding(.trailing)

                            Text(game.title)
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(8)
                                .shadow(color: .gray, radius: 3, x: 0, y: 2)
                        }
                        .padding(.horizontal)
                    }
                }
                .listStyle(PlainListStyle())
                .background(Color(UIColor.systemGroupedBackground))
            }
            .navigationTitle("Videojuegos")
            .onAppear {
                viewModel.loadGames()
            }
            .onChange(of: localCategory) { newCategory in
                viewModel.selectedCategory = newCategory
            }
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
