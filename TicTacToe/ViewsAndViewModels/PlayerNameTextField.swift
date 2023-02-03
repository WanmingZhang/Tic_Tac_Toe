//
//  PlayerNameTextField.swift
//  TicTacToe
//
//  Created by wanming zhang on 12/5/22.
//

import SwiftUI
struct PlayerNameTextField: View {
    let width = 90.0
    @State private var player1: String = ""
    @State private var player2: String = ""
    let player1Key = "player1_name"
    let player2Key = "player2_name"
    
    init() {
        let player1Name = UserDefaults.standard.string(forKey: player1Key) ?? ""
        let player2Name = UserDefaults.standard.string(forKey: player2Key) ?? ""
        
        self._player1 = State(initialValue: player1Name)
        self._player2 = State(initialValue: player2Name)
    }
    
    var body: some View {
        VStack {
            ForEach(Player.allCases, id: \.rawValue) { player in
                HStack {
                    Spacer()
                    Text (
                        player.rawValue == "Player 1" ? "name" : "opponent"
                    )
                    .frame(width: width, alignment: .trailing)
                    .font(.bodyFont20)
                    
                    TextField(player.rawValue, text: player.rawValue == "Player 1" ? $player1 : $player2)
                        .font(.bodyFont24)
                        .padding(8.0)
                        .disableAutocorrection(true)
                        .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(.brown, lineWidth: 4)
                            )
                        .onSubmit {
                            saveUerName()
                        }
                    Spacer(minLength: 24.0)
                }
            }
        }
    }
    
    func saveUerName() {
        UserDefaults.standard.setValue(self.player1, forKey: player1Key)
        UserDefaults.standard.setValue(self.player2, forKey: player2Key)
    }
}

struct UserNameTextFields_Previews: PreviewProvider {
    static var previews: some View {
        PlayerNameTextField()
    }
}




