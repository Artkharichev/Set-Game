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
                Text ("     Score: \(self.viewModel.score) ")
                Spacer()
                Button(action: newGame){
                    Text ("New Game ")
                }
                .foregroundColor(.black)
                .padding(.horizontal)
            }
            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation() {
                        self.viewModel.choose(card: card)
                    }
                }
                .padding(5)
                .transition(.offset(self.randomOfSet))
            }
            .padding()
            .onAppear {
                self.newGame()
            }
            
            addButton()
        }
    }
    private var randomOfSet: CGSize {
        let size = UIScreen.main.bounds.size
        
        let sings: [CGFloat] = [-1, 1]
        let x: CGFloat = .random(in: 0..<size.width) * sings.randomElement()!
        let y: CGFloat = .random(in: 0..<size.height) * sings.randomElement()!
        
        return CGSize(width: x, height: y)
    }
    
    private func newGame() {
        withAnimation(.easeInOut(duration: 0.7)) {
            self.viewModel.newGame()
        }
    }
    
    private func dealMoreCard() {
        withAnimation() {
            self.viewModel.addCards()
        }
    }
    
    private func addButton() -> some View {
        Group {
            if !self.viewModel.disableButtonAdd {
                Button(action: dealMoreCard){
                    Text ("  +3 card   ")
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
    
    private var figure: some View {
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
    
    private var shading: Double {
        switch card.shading {
        case .outlined: return card.shading.rawValue
        case .stripped: return card.shading.rawValue
        case .solid: return card.shading.rawValue
        }
    }
    
    private var pressedColor: Color {
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
    
    private let cardCornerRadius: CGFloat = 10.0
    private let cardLineWidth: CGFloat = 1.0
    private let cardSelectedLineWidth: CGFloat = 3.0
    private let figureLineWidth: CGFloat = 2.0
    private let rectangleCornerRadius: CGFloat = 3.0
}

//MARK: - Previews

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        return SoloSetGameView(viewModel: game)
    }
}
