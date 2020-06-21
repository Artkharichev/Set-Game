//
//  SoloSetGameView.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  View

import SwiftUI

struct SoloSetGameView: View {
    
    @ObservedObject var viewModel: SoloSetGame
    
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Button("New Game "){
                    self.viewModel.newGame()
                }
                .foregroundColor(.black)
                .padding(.horizontal)
            }
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
                .padding(5)
            }
            .padding()
            addButton()
        }
    }
    
    private func addButton() -> some View {
        Group {
            if !self.viewModel.disableButtonAdd {
                Button("  +3 card   "){
                    self.viewModel.addCards()
                }
                .background(Color.yellow.opacity(0.3))
                .cornerRadius(10)
            } else {
                Button("  No card   "){
                    self.viewModel.addCards()
                }
                .disabled(true)
            }
        }
        .font(.largeTitle)
        .foregroundColor(.black)
    }
}

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: cardCornerRadius).stroke(lineWidth: cardLineWidth)
                if card.isSelected {
                    RoundedRectangle(cornerRadius: cardCornerRadius)
                        .stroke(lineWidth: cardSelectedLineWidth)
                        .foregroundColor(pressedColor)
                    RoundedRectangle(cornerRadius: cardCornerRadius)
                        .opacity(0.06).foregroundColor(pressedColor)
                }
                VStack {
                    ForEach(0..<card.number.rawValue){ _ in
                        self.figure
                            .aspectRatio(2, contentMode: .fit)
                    }
                }
                .padding()
                .foregroundColor(card.color.description)
            }
        }
        .aspectRatio(0.7, contentMode: .fit)
    }
    
    var figure: some View {
        Group {
            if card.shape == .diamond {
                if card.shading == .outlined {
                    Diamond().stroke(lineWidth: figureLineWidth)
                } else {
                    if card.shading == .stripped {
                        Diamond().fill().opacity(shading)
                    } else {
                        Diamond().fill().opacity(shading)
                    }
                }
            }
            if card.shape == .oval {
                if card.shading == .outlined {
                    Capsule().stroke(lineWidth: figureLineWidth)
                } else {
                    if card.shading == .stripped {
                        Capsule().fill().opacity(shading)
                    } else {
                        Capsule().fill().opacity(shading)
                    }
                }
            }
            if card.shape == .squiggle {
                if card.shading == .outlined {
                    RoundedRectangle(cornerRadius: rectangleCornerRadius).stroke(lineWidth: figureLineWidth)
                } else {
                    if card.shading == .stripped {
                        RoundedRectangle(cornerRadius: rectangleCornerRadius).fill().opacity(shading)
                    } else {
                        RoundedRectangle(cornerRadius: rectangleCornerRadius).fill().opacity(shading)
                    }
                }
            }
        }
    }
    
    var shading: Double {
        switch card.shading {
        case .outlined: return card.shading.rawValue
        case .stripped: return card.shading.rawValue
        case .solid: return card.shading.rawValue
        }
    }
    
    var pressedColor: Color {
        if card.isChecking {
            if card.isMatched {
                return .green
            } else {
                return .red
            }
        } else {
            return .orange
        }
    }
    
    //MARK: - Drawing Constants
    
    let cardCornerRadius: CGFloat = 10.0
    let cardLineWidth: CGFloat = 1.0
    let cardSelectedLineWidth: CGFloat = 3.0
    let figureLineWidth: CGFloat = 2.0
    let rectangleCornerRadius: CGFloat = 3.0
}

//MARK: - Previews

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        return SoloSetGameView(viewModel: game)
    }
}
