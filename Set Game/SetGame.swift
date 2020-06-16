//
//  SetGame.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//
//  Model

import Foundation

struct SetGame  {
    
    private(set) var cards: Array<Card>
    
    private var selectedCards: [Card] = []
    
    private let numberOfFirstCards = 12
    
    private(set) var disableButtonAdd = false
    
    private var cardsCounter = 12 {
        didSet{
            for index in oldValue..<cardsCounter {
                cards[index].onScreen = true
            }
        }
    }
    
    mutating func choose(card: Card) {
        
        guard let choosenIndex = cards.firstIndex(matching: card) else {return}
        
        cards[choosenIndex].isSelected.toggle()
        
        selectedCards = cards.filter {$0.isSelected}
        
        if selectedCards.count == 3 {
            matching()
        }
    }
    
    mutating func matching() {
        //TODO: - DO IT!
    }
    
    mutating func addCards() {
        if cardsCounter < cards.count {
        cardsCounter += 3
        }
        if cardsCounter == cards.count {
            disableButtonAdd = true
        }
    }
    
    //Create Game
    init() {
        cards = Array<Card>()
        for number in CardNumber.allCases {
            for shape in CardShape.allCases {
                for color in CardColor.allCases {
                    for shading in CardShading.allCases {
                        cards.append(Card(shape: shape, number: number, color: color, shading: shading))
                    }
                }
            }
        }
        cards.shuffle()
        for index in 0..<numberOfFirstCards {
            cards[index].onScreen = true
        }
    }
    
    struct Card: Identifiable {
        var shape : CardShape
        var number: CardNumber
        var color: CardColor
        var shading: CardShading
        var isMatched = false {
            didSet{
                if isMatched {
                    onScreen = false
                }
            }
        }
        var onScreen = false
        var isSelected = false
        var id = UUID()
    }
    
}
