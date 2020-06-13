//
//  SoloSetGameView.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
// View

import SwiftUI

struct SoloSetGameView: View {
    
    @ObservedObject var viewModel: SoloSetGame
    
    var body: some View {

            Grid (viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    self.viewModel.choose(card: card)
                }
            .padding(5)
            }
        .padding()
        .foregroundColor(.red)
    }
}

struct CardView: View {
    var card: SetGame<String>.Card
    
    var body: some View{
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    private func body(for size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRadius).stroke(lineWidth: edgeLineWidth)
            Text(card.content)
            Diamond().opacity(0.5)
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    //MARK: - Drawing Constants
    
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * 0.75
    }
}






struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = SoloSetGame()
        return SoloSetGameView(viewModel: game)
    }
}
