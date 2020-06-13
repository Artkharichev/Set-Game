//
//  Figure.swift
//  Set Game
//
//  Created by Артём Харичев on 13.06.2020.
//  Copyright © 2020 Artem Kharichev. All rights reserved.
//

import SwiftUI

//let diamond = Diamond()
//let myRect = MyRect()
//
//var figures = [diamond, myRect] as [Any]

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let diagonal = min(rect.width, rect.height)
        let top = CGPoint(x: center.x, y: center.y + diagonal/2)
        let botton = CGPoint(x: center.x, y: center.y - diagonal/2)
        let left = CGPoint(x: center.x - diagonal/2, y: center.y)
        let right = CGPoint(x: center.x + diagonal/2, y: center.y)
        
        var p = Path()
        p.move(to: top)
        p.addLine(to: left)
        p.addLine(to: botton)
        p.addLine(to: right)
        p.addLine(to: top)
        return p
    }
}

struct MyRect: Shape {
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let diagonal = min(rect.width, rect.height)
        let topLeft = CGPoint(x: center.x - diagonal/2, y: center.y + diagonal/2)
        let bottonLeft = CGPoint(x: center.x - diagonal/2, y: center.y - diagonal/2)
        let bottonRight = CGPoint(x: center.x + diagonal/2, y: center.y - diagonal/2)
        let topRight = CGPoint(x: center.x + diagonal/2, y: center.y + diagonal/2)
        
        var p = Path()
        p.move(to: topLeft)
        p.addLine(to: bottonLeft)
        p.addLine(to: bottonRight)
        p.addLine(to: topRight)
        p.addLine(to: topLeft)
        return p
    }
}

