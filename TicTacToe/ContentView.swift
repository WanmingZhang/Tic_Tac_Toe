//
//  ContentView.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/23/22.
//

import SwiftUI

struct ContentView: View {
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    @State private var moves: [Move?] = Array(repeating: nil, count: 9)
    @State private var isBoardDisabled = false
    @State private var alertItem: AlertItem?
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    LazyVGrid(columns: columns) {
                        ForEach(0..<9) { i in
                            ZStack {
                                Circle()
                                    .foregroundColor(.orange.opacity(0.8))
                                Image(systemName: moves[i]?.indicator ?? "")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(.blue)
                                
                            }
                            .onTapGesture {
                                guard isOccupied(moves, i) == false else { return }
                                moves[i] = Move(player: .human, boardIndex: i)
                                if checkForWinning(.human, moves) {
                                    print("human wins")
                                    alertItem = AlertItem.humanWin
                                    return
                                }
                                if checkForDraw(moves) {
                                    print("draw")
                                    alertItem = AlertItem.drawGame
                                    return
                                }
                                isBoardDisabled = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    let position = determineComputerMoves(moves)
                                    moves[position] = Move(player: .computer, boardIndex: position)
                                    isBoardDisabled = false
                                    if checkForWinning(.computer, moves) {
                                        print("computer wins")
                                        alertItem = AlertItem.computerWin
                                        return
                                    }
                                    if checkForDraw(moves) {
                                        print("draw")
                                        alertItem = AlertItem.drawGame
                                        return
                                    }
                                }
                                
                            }
                        }
                    }
                    Spacer()
                }
                .disabled(isBoardDisabled)
                .padding()
                .alert(item: $alertItem) { alertItem in
                    Alert(title: alertItem.title,
                          message: alertItem.message,
                          dismissButton: .default(alertItem.buttonTitle, action: {
                        resetGame()
                    }))
                }
            }
        }
        .background(Color(.brown).opacity(0.5).ignoresSafeArea())
        
    }
    
    func isOccupied(_ moves: [Move?], _ index: Int) -> Bool {
        moves.contains { move in
            move?.boardIndex == index
        }
    }
    
    /**
     * If AI can win, then win
     * If AI cannot win, then block
     * If AI cannot block, take middle square
     * If AI cannot take middle square, take random available square
     */
    func determineComputerMoves(_ moves: [Move?]) -> Int {
        //If AI can win, then win
        let winning: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]
        let computerMoves = moves.compactMap { $0 }.filter { $0.player == .computer }
        let computerPos = Set(computerMoves.map { $0.boardIndex })
        
        for pattern in winning {
            let winningPos = pattern.subtracting(computerPos)
            if winningPos.count == 1 {
                if !isOccupied(moves, winningPos.first!) {
                    return winningPos.first!
                }
            }
        }
        // If AI cannot win, then block
        let humanMoves = moves.compactMap { $0 }.filter { $0.player == .human }
        let humanPos = Set(humanMoves.map { $0.boardIndex })
        
        for pattern in winning {
            let winningPos = pattern.subtracting(humanPos)
            if winningPos.count == 1 {
                if !isOccupied(moves, winningPos.first!) {
                    return winningPos.first!
                }
            }
        }
        
        //If AI cannot block, take middle square
        let centerSquare = 4
        if !isOccupied(moves, centerSquare) {
            return centerSquare
        }
        
        //If AI cannot take middle square, take random available square
        var position = Int.random(in: 0..<9)
        while isOccupied(moves, position) == true {
            position = Int.random(in: 0..<9)
        }
        return position
    }
    
    func checkForWinning(_ player: Player, _ moves: [Move?]) -> Bool {
        let winning: Set<Set<Int>> = [[0,1,2], [3,4,5], [6,7,8], [0,4,8], [2,4,6], [0,3,6], [1,4,7], [2,5,8]]
        
        let nonnilPlayerMoves = moves.compactMap { $0 }.filter { $0.player == player }
        let playerPos = Set(nonnilPlayerMoves.map { $0.boardIndex })
        print("playerPos = \(playerPos)")
        
        for pattern in winning where pattern.isSubset(of: playerPos) {
            return true
        }
        
        return false
    }
    
    func checkForDraw(_ moves: [Move?]) -> Bool {
        return moves.compactMap { $0 }.count == 9
    }
    
    func resetGame() {
        moves = Array(repeating: nil, count: 9)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
