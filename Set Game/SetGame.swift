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
    
    private var wasJustMatch = false
    
    private(set) var canCheck = false
    
    private var cardsCounter = 12 {
        didSet{
            for index in oldValue..<cardsCounter {
                cards[index].onScreen = true
            }
        }
    }
    
    mutating func choose(card: Card) {
        
        guard let choosenIndex = cards.firstIndex(matching: card) else {return}
        
        
        if cards[choosenIndex].isChecking {
            
            checkAndReplace(for: choosenIndex)
            
        } else {
            cards[choosenIndex].isSelected.toggle()
        }
        
        selectedCards = cards.filter {$0.isSelected}
        
        if selectedCards.count == 3 {
            checking()
        }
        
        
        if selectedCards.count > 3 {
            
            checkAndReplace(for: choosenIndex)
            
            cards[choosenIndex].isSelected = true
            selectedCards = cards.filter {$0.isSelected}
        }
    }
    
    mutating func checking()  {
        
        for index in 0..<cards.count {
            for ind in 0...2 {
                if selectedCards[ind].id == cards[index].id {
                    cards[index].isChecking = true
                }
            }
        }
        
        guard ((selectedCards[0].number == selectedCards[1].number && selectedCards[0].number == selectedCards[2].number) || (selectedCards[0].number != selectedCards[1].number && selectedCards[0].number != selectedCards[2].number && selectedCards[1].number != selectedCards[2].number)) else {return}
        
        guard ((selectedCards[0].color == selectedCards[1].color && selectedCards[0].color == selectedCards[2].color) || (selectedCards[0].color != selectedCards[1].color && selectedCards[0].color != selectedCards[2].color && selectedCards[1].color != selectedCards[2].color)) else {return}
        
        guard ((selectedCards[0].shading == selectedCards[1].shading && selectedCards[0].shading == selectedCards[2].shading) || (selectedCards[0].shading != selectedCards[1].shading && selectedCards[0].shading != selectedCards[2].shading && selectedCards[1].shading != selectedCards[2].shading)) else {return}
        
        guard ((selectedCards[0].shape == selectedCards[1].shape && selectedCards[0].shape == selectedCards[2].shape) || (selectedCards[0].shape != selectedCards[1].shape && selectedCards[0].shape != selectedCards[2].shape && selectedCards[1].shape != selectedCards[2].shape)) else {return}
        
        for index in 0..<cards.count {
            for ind in 0...2 {
                if selectedCards[ind].id == cards[index].id {
                    cards[index].isMatched = true
                }
            }
        }
        wasJustMatch = true
    }
    
    mutating func checkAndReplace(for index: Int) {
        
        selectedCards.removeAll()
        
        for index in 0..<cards.count {
            cards[index].isSelected = false
            cards[index].isChecking = false
            if wasJustMatch {
                if cards[index].isMatched {
                    cards[index].onScreen = false
                }
            }
        }
        
        if wasJustMatch {
            addCards()
            wasJustMatch = false
        } else {
            cards[index].isSelected = true
        }
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
        var isMatched = false
        var onScreen = false
        var isSelected = false
        var isChecking = false
        var id = UUID()
    }
    
}
