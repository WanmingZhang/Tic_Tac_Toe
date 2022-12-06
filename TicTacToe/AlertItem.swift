//
//  AlertItem.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/27/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

extension AlertItem {
    static let humanWin    = AlertItem(title: Text("You win!"), message: Text(""), buttonTitle: Text("New Game"))
    static let computerWin = AlertItem(title: Text("Uh-oh you lost!"), message: Text(""), buttonTitle: Text("Play Again"))
    static let drawGame    = AlertItem(title: Text("It's a tie!"), message: Text(""), buttonTitle: Text("New Game"))
}
