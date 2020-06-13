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
    
    @Published private var model: SetGame<String> = SoloSetGame.createSetGame()
    
    static func createSetGame() -> SetGame<String> {
        let figures = ["Diamond","Rectangle","Oval"]
        return SetGame<String>() {figures[$0]}
    }
    
    //MARK: - Access to the Model
    var cards: Array<SetGame<String>.Card> {
        var cardsToScreen = Array<SetGame<String>.Card>()
        for card in model.cards {
            if card.onScreen {
                cardsToScreen.append(card)
            }
        }
        return cardsToScreen
    }
    
    //MARK: - Intents
    func choose(card: SetGame<String>.Card) {
        model.choose(card: card)
    }
}
