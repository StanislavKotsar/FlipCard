//
//  ConcetrationThemeChooserViewController.swift
//  StanfordLecture1
//
//  Created by Станислав Коцарь on 25.03.2018.
//  Copyright © 2018 Станислав Коцарь. All rights reserved.
//

import UIKit

class ConcetrationThemeChooserViewController: UIViewController, UISplitViewControllerDelegate {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎱⛸🛷🏄‍♂️🏊‍♀️🧘‍♀️🏇🏌️‍♂️🤾‍♀️🤺⛹️‍♂️🚴‍♀️🚣‍♂️🤸‍♀️",
        "Animals": "🐶🐱🐭🦊🙈🐔🐧🐴🦄🦍🐘🐫🦒🐂🐄🐏🐕🐩",
        "Faces": "😀🤣💩👽😻👲🧕👮‍♀️👷‍♀️💂‍♀️🕵️‍♂️👨‍⚕️👩‍🍳👩‍🎓🤷‍♂️💇‍♂️🧛‍♂️🧝‍♀️🤵"
    ]
    
    
    override func viewDidLoad() {
        splitViewController?.delegate = self
    }
    
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if let cvc = secondaryViewController as? ConcetrationViewController {
            if cvc.theme == nil {
                return true
            }
        }
        return false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentTitle = (sender as? UIButton)?.currentTitle, let themeName = themes[currentTitle] {
            if let vc = segue.destination as? ConcetrationViewController {
                vc.theme = themeName
                lastSeguedToConcetrationViewController = vc
            }
        }
    }
    
    @IBAction func buttonTaped(_ sender: UIButton) {
        if let cvc =  splitViewDetailConcetrationViewController {
            if let currentTitle = sender.currentTitle, let themeName = themes[currentTitle] {
                cvc.theme = themeName
            }
        } else if let cvc = lastSeguedToConcetrationViewController {
            
            if let currentTitle = sender.currentTitle, let themeName = themes[currentTitle] {
                cvc.theme = themeName
            }
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            print("performing")
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
    
    private var splitViewDetailConcetrationViewController : ConcetrationViewController? {
        return splitViewController?.viewControllers.last as? ConcetrationViewController
    }
    
    private var lastSeguedToConcetrationViewController: ConcetrationViewController? {
        didSet {
            print("set")
        }
    }
    
}
