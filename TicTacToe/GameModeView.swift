//
//  GameModeView.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/28/22.
//

import SwiftUI

enum Mode: String, CaseIterable {
    case onePlayer = "one player"
    case twoPlayer = "two players"
}

struct GameModeView: View {
    let spacer_1 = 24.0
    let spacer_2 = 15.0
    let spacer_3 = 100.0
    let cornerRadius = 25.0
    let borderLineWidth = 5.0
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont.titleFont ?? UIFont.systemFont(ofSize: 36)]
        }
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    Spacer(minLength: spacer_3)
                    HStack {
                        Spacer(minLength: spacer_1)
                        LazyVStack(alignment: .center) {
                            Spacer(minLength: spacer_3)
                            ForEach(Mode.allCases, id: \.rawValue) { mode in
                                let linkText = mode.rawValue
                                let fontColor = mode == .onePlayer ? Color.blue : Color.purple
                                
                                NavigationLink(destination: GameSetupView()) {
                                    VStack {
                                        Text(linkText)
                                            .foregroundColor(fontColor)
                                            .font(.mediumBodyFont)
                                    }
                                }
                                Spacer(minLength: spacer_2)
                            }
                            Spacer(minLength: spacer_3)
                        }
                        .background(Color.orange.opacity(0.25))
                        .overlay(
                                    RoundedRectangle(cornerRadius: cornerRadius)
                                        .stroke(Color.black, lineWidth: borderLineWidth)
                                )
                        Spacer(minLength: spacer_1)
                    }
                    Spacer()
                }
            }
            .navigationBarTitle("Tic Tac Toe").font(.titleFont)
            .edgesIgnoringSafeArea(.top)
            .navigationBarBackButtonHidden(true)
            .background(Color.board_bg_color.ignoresSafeArea())

        }
    }
}

struct GameModeView_Previews: PreviewProvider {
    static var previews: some View {
        GameModeView()
    }
}



