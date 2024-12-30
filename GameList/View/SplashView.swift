//
//  SplashView.swift
//  GameList
//
//  Created by Ariadna Cecilia López Colín on 29/12/24.
//

import SwiftUI

struct SplashView: View {
    typealias ConstantSize = SplashViewConstants.sizes
    typealias ConstantString = SplashViewConstants.strings
    @StateObject private var viewModel = SplashViewModel()
    @State private var rotateLogo = false
    @State private var opacity: Double = ConstantSize.transitionOpacity
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(ConstantSize.blueOpacity), Color.purple.opacity(ConstantSize.purpleOpacity)]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            Group {
                if viewModel.isLoaded {
                    GameListView()
                        .transition(.opacity)
                } else {
                    VStack {
                        Image(systemName: ConstantString.SplashViewImage)
                            .resizable()
                            .frame(width: ConstantSize.frameWidht, height: ConstantSize.frameHeight)
                            .rotationEffect(.degrees(rotateLogo ? ConstantSize.rotateLogoOne : ConstantSize.rotateLogoTwo))
                            .opacity(opacity)
                            .onAppear {
                                withAnimation(.easeIn(duration: ConstantSize.animationDuration)) {
                                    opacity = ConstantSize.animationOpacity
                                }
                                withAnimation(.linear(duration: ConstantSize.linearDuration).repeatForever(autoreverses: false)) {
                                    rotateLogo.toggle()
                                }
                                viewModel.loadGames()
                            }
                        
                        Text(ConstantString.SplashViewText)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.top, ConstantSize.textTop)
                            .opacity(opacity)
                            .onAppear {
                                withAnimation(.easeIn(duration: ConstantSize.textDuration)) {
                                    opacity = ConstantSize.textOpacity
                                }
                            }
                        
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: Color.white))
                            .scaleEffect(ConstantSize.scaleEffect)
                            .padding(.top, ConstantSize.progressViewPadding)
                    }
                    .transition(.move(edge: .bottom))
                    .onAppear {
                        withAnimation(.easeIn(duration: ConstantSize.transitionAnimationDuration)) {
                            opacity = ConstantSize.transitionAnimationDuration
                        }
                    }
                }
            }
        }
    }
}

