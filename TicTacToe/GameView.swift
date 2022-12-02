//
//  ContentView.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/23/22.
//

import SwiftUI

struct GameView: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject private var viewModel = GameViewModel()
    @State private var difficulty: AILevel
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    init(_ difficulty: AILevel) {
        _difficulty = State(initialValue: difficulty)
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    LazyVGrid(columns: columns) {
                        ForEach(0..<9) { i in
                            ZStack {
                                gameSquare()
                                playerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                                
                            }
                            .onTapGesture {
                                viewModel.processPlayerMove(at: i, with: difficulty)
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
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .background(Color.board_bg_color.ignoresSafeArea())
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Text("BACK").font(.mediumBodyFont)
        }), trailing: Button(action: {
            //
        }, label: {
            Button {
                viewModel.resetGame()
            } label: {
                Text("NEW").font(.mediumBodyFont)
            }
        }))
    }

    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let defaultDifficulty = AILevel.hard
        GameView(defaultDifficulty)
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
