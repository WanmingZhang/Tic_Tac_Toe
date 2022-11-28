//
//  Move.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/23/22.
//

import Foundation

enum Player: CaseIterable {
    case human
    case computer
}

struct Move {
    var player: Player
    var boardIndex: Int
    var indicator: String {
        player == .human ? "xmark" : "circle"
    }
}
