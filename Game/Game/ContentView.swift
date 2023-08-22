//
//  ContentView.swift
//  Game
//
//  Created by artem on 21.08.2023.
//

import SwiftUI
import SwiftUI
import SpriteKit

struct ContentView: View {
    var body: some View {
        NavigationView {
            NavigationLink(destination: GameView()) {
                Text("Play Game")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .navigationBarHidden(true)
    }
}

struct GameView: View {
    @State private var isGameStarted = false
    
    var body: some View {
        VStack {
       
            Text("Catch the Figures!")
                .font(.title)
                .padding()
            
            if isGameStarted {
                Spacer()
                SpriteView(scene: GameScene(size: CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 100)
                    .ignoresSafeArea()
            }
            
            Button(action: {
                isGameStarted.toggle()
            }) {
                Text(isGameStarted ? "Stop" : "Start")
                    .font(.headline)
                    .padding()
                    .background(isGameStarted ? Color.red : Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.bottom, 100)
        .navigationBarBackButtonHidden(true)
    }
}
