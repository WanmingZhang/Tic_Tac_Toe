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
    @State private var name: String = "Name"
    @State private var shouldStart: Bool = false
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    let columns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack {
            VStack {
                Spacer(minLength: 150)
                HStack {
                    Spacer(minLength: spacer)
                    VStack {
                        Spacer(minLength: spacer)
                        Text("One Player").font(.smallBodyFont)
                        Spacer(minLength: spacer)
                        VStack(alignment: .center) {
                            TextField("Name", text: $name)
                            TextField("Name", text: $name)
                        }
                        Spacer(minLength: spacer)
                        LazyVGrid(columns: columns) {
                            ForEach(0..<3) { i in
                                ZStack {
                                    self.buildButton(from: AILevel.allCases[i])
                                    
                                }
                                .onTapGesture {
                                    
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
            Text("BACK").font(.mediumBodyFont)
        }), trailing: Button(action: {
            //
        }, label: {
            NavigationLink(destination: GameView(difficulty)) {
                Text("Start").font(.mediumBodyFont)
                     }
        }))
    }
    
    func buildButton(from difficulty: AILevel) -> some View {
        let difficultyLevel = difficulty.rawValue
        let fontColor = self.fontColorBy(difficulty)
        
        let button =
        Button(action: {
            self.difficulty = difficulty
            print(difficultyLevel)
        }) {
            Text(difficultyLevel)
                .padding(10)
                .foregroundColor(fontColor)
                .font(.smallBodyFont)
        }
        .buttonStyle(ToggleButtonStyle())
        
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

struct ToggleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(configuration.isPressed ? Color.white : Color.clear)
            .background(configuration.isPressed ? Color.white : Color.clear)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
            
    }
}
