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
    }

    // View actions
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumber(numberText)
        updateUI()
    }

    @IBAction func tappedAdditionButton(_ sender: UIButton) {
        guard calculator.canAddOperator else {
            return presentAlert(with: "Un operateur est déja mis !")
        }
            calculator.addOperator("+")
            updateUI()
        }

    @IBAction func tappedSubstractionButton(_ sender: UIButton) {
        guard calculator.canAddOperator else {
            return presentAlert(with: "Un operateur est déja mis !")
        }
            calculator.addOperator("-")
            updateUI()
    }

    @IBAction func tappedMultiplyButton(_ sender: UIButton) {
        guard calculator.canAddOperator else {
            return presentAlert(with: "Un operateur est déja mis !")
        }
            calculator.addOperator("×")
            updateUI()
    }

    @IBAction func tappedDivideButton(_ sender: UIButton) {
        guard calculator.canAddOperator else {
            return presentAlert(with: "Un operateur est déja mis !")
        }
            calculator.addOperator("÷")
            updateUI()
    }

    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            return presentAlert(with: "Entrez une expression correcte !")
        }

        guard calculator.hasEnoughElements else {
            return presentAlert(with: "Démarrez un nouveau calcul !")
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
