//
//  ContentView.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/23/22.
//

import SwiftUI

struct GameView: View {
    
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    LazyVGrid(columns: viewModel.columns) {
                        ForEach(0..<9) { i in
                            ZStack {
                                gameSquare()
                                playerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                                
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(at: i)
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(viewModel.isBoardDisabled)
                .padding()
                .alert(item: $viewModel.alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle, action: {
                        viewModel.resetGame()
                    }))
                }
            }
        }
        .background(Color.board_bg_color.ignoresSafeArea())
        
    }

    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}

struct gameSquare: View {
    var body: some View {
        Circle()
            .foregroundColor(.circle_bg_color)
    }
}

struct playerIndicator: View {
    var systemImageName: String
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.blue)
    }
    

}
