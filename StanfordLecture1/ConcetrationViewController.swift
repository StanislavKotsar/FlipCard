//
//  ConcetrationViewController.swift
//  StanfordLecture1
//
//  Created by Станислав Коцарь on 04.03.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit

class ConcetrationViewController: UIViewController {
    
    lazy var game = Concetration(numberOfPairsOfCards:  numberOfPairsOfCards)
    @IBOutlet var buttonsCollection: [UIButton]!
    @IBOutlet weak var label: UILabel! {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet weak var countLabel: UILabel!
    var cardIndex : Int?
    
    var numberOfPairsOfCards: Int {
        return (buttonsCollection.count + 1) / 2
    }
    override func viewDidLoad() {
        
    }
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = buttonsCollection.index(of: sender) {
            game.flipsCount += 1
            updateFlipCountLabel()
            cardIndex = Int(cardNumber)
            game.chooseCard(at: cardNumber)
            checkForEndGame()
            updateViewFromModel()
        } else {
            print("chosen card was not in card buttons")
        }
    }
    
    func updateViewFromModel() {
        if buttonsCollection != nil {
            for index in buttonsCollection.indices {
                let button = buttonsCollection[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    if self.cardIndex == Int(index) {
                        flipCard(button: button, background: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                    } else {
                        button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                    }
                    
                } else {
                    button.setTitle("", for: .normal)
                    if card.isMatched {
                        flipCard(button: button, background: #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0))

                    } else {
                        if button.backgroundColor !=  #colorLiteral(red: 0.1215686275, green: 0.4784313725, blue: 0.9490196078, alpha: 1) {
                            flipCard(button: button, background: #colorLiteral(red: 0.1215686275, green: 0.4784313725, blue: 0.9490196078, alpha: 1))
                        } else {
                         button.backgroundColor =  #colorLiteral(red: 0.1215686275, green: 0.4784313725, blue: 0.9490196078, alpha: 1)
                        }
                    }
                }
            }
            countLabel.text = "Count: \(game.points)"
        }
    }
    
    
    func flipCard (button: UIButton, background: UIColor) {
        UIView.transition(with: button,
                          duration: 0.5,
                          options: .transitionFlipFromLeft,
                          animations: {
                            button.backgroundColor = background
                            
        })
    }
    
    
    var theme : String? {
        didSet {
            emojiCollection = theme ?? ""
            emoji = [:]
            updateViewFromModel()
        }
    }
    private var emojiCollection = "🎃👻🍆💩🦄🍄🌏🍓🌯🍑🌶🏀🎲🚽💈🎾"
    private var emoji = [Card:String]()
    
    private func emoji (for card: Card) -> String {
        if emoji[card] == nil, emojiCollection.count > 0 {
            let randomStringIndex = emojiCollection.index(emojiCollection.startIndex, offsetBy: emojiCollection.count.arc4random)
            emoji[card] = String(emojiCollection.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
    
    func checkForEndGame () {
        if game.pairsNumber == game.count {
            let alert = UIAlertController(title: "Game Over! Play again", message: "", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { (action) in
                
                self.game = Concetration(numberOfPairsOfCards: (self.buttonsCollection.count + 1) / 2 )
                
                for index in self.buttonsCollection.indices {
                    let button = self.buttonsCollection[index]
                        button.setTitle("", for: .normal)
                        button.backgroundColor =  #colorLiteral(red: 0.1215686275, green: 0.4784313725, blue: 0.9490196078, alpha: 1)
                }
                self.emojiCollection = "🎃👻🍆💩🦄🍄🌏🍓🌯🍑🌶🏀🎲🚽💈🎾"
                
                self.emoji = [Card:String]()
                self.countLabel.text = "Count: \(self.game.points)"
                self.updateFlipCountLabel()
                
        }
            
            alert.addAction(action)
            
            present(alert, animated: true, completion: nil)
    }

}
    private func updateFlipCountLabel () {
        let attributes : [NSAttributedStringKey: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: #colorLiteral(red: 0.1215686275, green: 0.4784313725, blue: 0.9490196078, alpha: 1)
        ]
        let atributeString = NSAttributedString(string: "Flips: \(game.flipsCount)", attributes: attributes)
        label.attributedText = atributeString
    }
    
    func countDidChange() {
        countLabel.text = "Count: \(game.points)"
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
