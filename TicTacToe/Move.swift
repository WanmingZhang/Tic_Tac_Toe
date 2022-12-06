//
//  Move.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/23/22.
//

import Foundation

enum Player: String, CaseIterable {
    case human = "Player 1"
    case computer = "Player 2"
}

struct Move {
    var player: Player
    var boardIndex: Int
    var indicator: String {
        player == .human ? "xmark" : "circle"
    }
}
