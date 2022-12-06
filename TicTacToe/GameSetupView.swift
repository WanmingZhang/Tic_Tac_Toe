//
//  GameSetupView.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/28/22.
//

import SwiftUI

struct GameSetupView: View {
    let spacer = 24.0
    let cornerRadius = 25.0
    let borderLineWidth = 5.0
    
    @State private var difficulty: AILevel = .hard
    @State private var didTap = Array(repeating: false, count: AILevel.allCases.count)
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 150)
                HStack {
                    Spacer(minLength: spacer)
                    VStack {
                        Spacer(minLength: 8)
                        Text("One Player").font(.bodyFont24)
                        Spacer(minLength: spacer)
                        UserNameTextFields()
                        Spacer(minLength: 8)
                        LazyVGrid(columns: columns) {
                            ForEach(0..<3) { i in
                                ZStack {
                                    self.buildButton(at: i)
                                }
                            }
                        }
                        Spacer(minLength: spacer)
                    }
                    .background(Color.orange.opacity(0.25))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.black, lineWidth: borderLineWidth)
                    )
                    Spacer(minLength: spacer)
                }
                Spacer(minLength: 150)
            }
        }
        .edgesIgnoringSafeArea(.top)
        .navigationBarBackButtonHidden(true)
        .background(Color.board_bg_color.ignoresSafeArea())
        .navigationBarItems(leading: Button(action: {
            self.mode.wrappedValue.dismiss()
        }, label: {
            Text("BACK").font(.bodyFont30)
        }), trailing: Button(action: {
            //
        }, label: {
            NavigationLink(destination: GameView(difficulty)) {
                Text("Start").font(.bodyFont30)
                     }
        }))
    }
    
    func buildButton(at idx: Int) -> some View {
        let difficulty = AILevel.allCases[idx]
        let difficultyLevel = difficulty.rawValue
        let fontColor = self.fontColorBy(difficulty)
        
        let button =
        Button(action: {
            self.difficulty = difficulty
            for i in 0..<AILevel.allCases.count {
                if i == idx {
                    didTap[i] = true
                } else {
                    didTap[i] = false
                }
            }
            print(difficultyLevel)
        }) {
            Text(difficultyLevel)
                .padding(10)
                .foregroundColor(fontColor)
                .font(.bodyFont24)
                .overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(didTap[idx] == true ? .white : .clear,
                    lineWidth: 3))
        }
        .background(didTap[idx] == true ? .yellow : .clear, in: RoundedRectangle(cornerRadius: cornerRadius))

        return button
    }
    
    
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

struct GameSetupView_Previews: PreviewProvider {
    static var previews: some View {
        GameSetupView()
    }
}

