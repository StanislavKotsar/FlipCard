//
//  ViewController.swift
//  StanfordLecture1
//
//  Created by Станислав Коцарь on 04.03.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    lazy var game = Concetration(numberOfPairsOfCards:  numberOfPairsOfCards)
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var label: UILabel!
    var numberOfPairsOfCards: Int {
        return (buttonsCollection.count + 1) / 2
    }
    var flipsCount = 0 {
        didSet {
            label.text = "Flips: \(flipsCount)"
        }
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipsCount += 1
        if let cardNumber = buttonsCollection.index(of: sender) {
            game.chooseCard(at: cardNumber)
            checkForEndGame()
            updateViewFromModel()
        } else {
            print("chosen card was not in card buttons")
        }
    }
    
    func updateViewFromModel() {
        for index in buttonsCollection.indices {
            let button = buttonsCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor =  card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiCollection = ["🎃", "👻", "🍆", "💩", "🦄", "🍄", "🌏", "🍓", "🌯", "🍑", "🌶", "🏀", "🎲", "🚽", "💈", "🎾"]
    
    var emoji = [Int:String]()
    
    func emoji (for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiCollection.count > 0 {
            emoji[card.identifier] = emojiCollection.remove(at: emojiCollection.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    func checkForEndGame () {
        if game.pairsNumber == game.count {
            let alert = UIAlertController(title: "Game Over! Play again", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                
                self.game = Concetration(numberOfPairsOfCards: (self.buttonsCollection.count + 1) / 2 )
                
                for index in self.buttonsCollection.indices {
                    let button = self.buttonsCollection[index]
                        button.setTitle("", for: .normal)
                        button.backgroundColor =  #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
                }
                self.emojiCollection = ["🎃", "👻", "🍆", "💩", "🦄", "🍄", "🌏", "🍓", "🌯", "🍑", "🌶", "🏀", "🎲", "🚽", "💈", "🎾"]
                
                self.emoji = [Int:String]()
                
                self.flipsCount = 0
                
        }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
    }

}
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
          return  Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
