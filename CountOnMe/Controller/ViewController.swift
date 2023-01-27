//
//  ViewController.swift
//  SimpleCalc
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var textView: UITextView!
    @IBOutlet var numberButtons: [UIButton]!

    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    func updateUI() {
        textView.text = calculator.display
        textView.scrollToBotom()
    }

    @IBAction func clearAll(_ sender: UIButton) {
        calculator.clearAll()
        updateUI()
    }

    @IBAction func removeLastEntry(_ sender: UIButton) {
        guard calculator.hasResult == false else {
            return presentAlert(with: "Commencez un nouveau calcul !")
        }
        calculator.removeEntry()
        updateUI()
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumber(numberText)
        updateUI()
    }

    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }

        guard calculator.canAddOperator else {
                    return presentAlert(with: "Un opérateur a déjà été ajouté.")

        }
        calculator.addOperator(operatorText)
        updateUI()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            return presentAlert(with: "Entrez une expression correcte !")
        }

        guard calculator.hasEnoughElements else {
            return presentAlert(with: "Démarrez un nouveau calcul !")
        }

        guard !calculator.isImpossibleToDivide else {
            return presentAlert(with: "Impossible de diviser par zéro")
        }
        calculator.compute()
        updateUI()
    }

    fileprivate func presentAlert(with message: String) {
        let alertVC = UIAlertController(
            title: "Erreur",
            message: message,
            preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
