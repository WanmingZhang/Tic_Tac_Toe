//
//  PlayerNameView.swift
//  TicTacToe
//
//  Created by wanming zhang on 1/24/23.
//

import SwiftUI

struct PlayerNameView: View {
    
    @State private var player1: String = "Player 1"
    @State private var player2: String = "Player 1"
    var body: some View {
        HStack {
            ForEach(Player.allCases, id: \.rawValue) { player in
                HStack {
                    Spacer()
                    let name = player.rawValue == "Player 1" ? player1 : player2
                    let img = player.rawValue == "Player 1" ? "xmark" : "circle"
                    Label {
                        Text(name)
                    } icon: {
                        Image(systemName: img)
                            .foregroundColor(Color.blue)
                    }
                    .font(.bodyFont24)
                    .padding(8.0)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.brown, lineWidth:2.0)
                        )
                    Spacer(minLength: 10.0)
                }
            }
        }
    }
}

struct PlayerNameView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerNameView()
    }
}
