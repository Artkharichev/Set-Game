//
//  Figure.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let diagonal = min(rect.width, rect.height)
        let top = CGPoint(x: center.x, y: center.y + diagonal/2)
        let botton = CGPoint(x: center.x, y: center.y - diagonal/2)
        let left = CGPoint(x: center.x - diagonal, y: center.y)
        let right = CGPoint(x: center.x + diagonal, y: center.y)
        
        var path = Path()
        path.move(to: top)
        path.addLine(to: left)
        path.addLine(to: botton)
        path.addLine(to: right)
        path.addLine(to: top)
        return path
    }
}


