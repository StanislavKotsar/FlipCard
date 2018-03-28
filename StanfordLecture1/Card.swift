//
//  File.swift
//  StanfordLecture1
//
//  Created by Станислав Коцарь on 06.03.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int {
        return identifier
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    var hasBeenFlipped = false
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    
    
    static var identifierFactory = 0
    
    
    static func getUniqueIdentifier () -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
