//
//  SetGame.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  Model

import SwiftUI

struct SetGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: Array<Card>
    
    // Game Parameters
    private let numbersOfDifferentContent = 3
    private let numbersOfContent = [1,2,3]
    private let colors = [Color.red, Color.green, Color.purple]
    private let textures = [0.0, 0.4, 1.0]
    
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
    }
    
    //Create Game
    init(cardContentFactor: (Int) -> CardContent) {
        cards = Array<Card>()
        var identifire = 0
        for exemplar in 0..<numbersOfDifferentContent {
            let content = cardContentFactor(exemplar)
            for number in numbersOfContent {
                for color in colors {
                    for texture in textures {
                        identifire += 1
                        cards.append(Card(content: content, numberOfContent: number, color: color, texture: texture, id: identifire))
                    }
                }
            }
        }
        cards.shuffle()
        for index in 0..<12 {
            cards[index].onScreen = true
        }
    }
    
    struct Card: Identifiable {
        var content : CardContent
        var numberOfContent: Int
        var color: Color
        var texture: Double
        var isMatched = false
        var onScreen = false
        var id: Int
    }
}
