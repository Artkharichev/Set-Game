//
//  SoloSetGame.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  ViewModel

import SwiftUI

class SoloSetGame: ObservableObject {
    
    @Published private var game = SetGame()
    
    
    //MARK: - Access to the Model
    var cards: Array<SetGame.Card> {
        var cardsToScreen = Array<SetGame.Card>()
        for card in game.cards {
            if card.onScreen {
                cardsToScreen.append(card)
            }
        }
        return cardsToScreen
    }
    
    var disableButtonAdd: Bool {
        game.disableButtonAdd
    }
    
    var canCheck: Bool {
        game.canCheck
    }
    
    //MARK: - Intents
    func choose(card: SetGame.Card) {
        game.choose(card: card)
    }
    
    func newGame() {
        game = SetGame()
    }
    
    func addCards(){
        game.addCards()
    }
}
