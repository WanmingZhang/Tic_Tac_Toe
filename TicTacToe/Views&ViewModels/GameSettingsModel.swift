//
//  GameSettingsModel.swift
//  TicTacToe
//
//  Created by wanming zhang on 1/25/23.
//

import Foundation
import SwiftUI

class GameSettingsModel: ObservableObject {
    
    func fontColorBy(_ difficulty: AILevel) -> Color {
        switch difficulty {
        case .easy:
            return Color.mint
        case .medium:
            return Color.blue
        case .hard:
            return Color.purple
        }
    }
}
