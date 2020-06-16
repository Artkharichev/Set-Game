//
//  GameCard.swift
//  Set Game
//
//  Created by Артём Харичев on 15.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

enum CardShape: CaseIterable {
    case oval
    case squiggle
    case diamond
    
    var description: String {
        switch self {
        case .oval: return "O"
        case .diamond: return "◇"
        case .squiggle: return "~"
        }
    }
}

enum CardNumber: Int, CaseIterable {
    case one = 1
    case two = 2
    case three = 3
}

enum CardColor: CaseIterable {
    case pink
    case purple
    case green
    
    var description: Color {
        switch self {
        case .pink: return Color.pink
        case .purple: return Color.purple
        case .green: return Color.green
        }
    }
}

enum CardShading: Double, CaseIterable {
    case solid = 1.0
    case stripped = 0.4
    case outlined = 0.0
}
