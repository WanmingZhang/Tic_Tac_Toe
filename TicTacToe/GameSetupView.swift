//
//  GameSetupView.swift
//  TicTacToe
//
//  Created by wanming zhang on 11/28/22.
//

import SwiftUI

enum AIDifficulty: String, CaseIterable {
    case easy = "easy"
    case medium = "medium"
    case hard = "hard"
}

struct GameSetupView: View {
    let spacer_1 = 24.0
    let spacer_2 = 15.0
    let spacer_3 = 100.0
    let cornerRadius = 25.0
    let borderLineWidth = 5.0
    @State private var difficulty: AIDifficulty = .hard
    @State private var name: String = "Name"
    @State private var shouldStart: Bool = false
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 1.5 * spacer_3)
                HStack {
                    Spacer(minLength: spacer_2)
                    VStack {
                        Spacer(minLength: spacer_2)
                        Text("One Player").font(.smallBodyFont)
                        VStack(alignment: .center) {
                            TextField("Name", text: $name)
                            TextField("Name", text: $name)
                        }
                        LazyHStack(alignment: .center) {
                            Spacer(minLength: spacer_2)
                            ForEach(AIDifficulty.allCases, id: \.rawValue) { difficulty in
                                self.buildButton(from: difficulty)
                            }
                            Spacer(minLength: spacer_2)
                        }
                    }
                    .background(Color.orange.opacity(0.25))
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .stroke(Color.black, lineWidth: borderLineWidth)
                    )
                    Spacer(minLength: spacer_2)
                }
                Spacer(minLength: 1.5 * spacer_3)
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
            NavigationLink(destination: GameView(difficulty)) {
                Text("Start").font(.mediumBodyFont)
                     }
        }))
    }
    
    func buildButton(from difficulty: AIDifficulty) -> some View {
        let difficultyLevel = difficulty.rawValue
        let fontColor = self.fontColorBy(difficulty)
        let button =
        Button(action: {
            self.difficulty = difficulty
            print(difficultyLevel)
        }) {
            Text(difficultyLevel)
                .padding()
                .foregroundColor(fontColor)
                .font(.smallBodyFont)
        }
        return button
    }
    
    
    func fontColorBy(_ difficulty: AIDifficulty) -> Color {
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
