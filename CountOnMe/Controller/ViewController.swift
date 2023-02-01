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

    var calculator = Calculator()

    // View Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        updateUI()
    }

    // Pairs the display to the textView of the controller, and scrolls at the bottom of the textView when needed
    func updateUI() {
        textView.text = calculator.display
        textView.scrollToBottom()
    }

    // IBaction linked to the AC button and clearAll method, removes every entry in textView
    @IBAction func clearAll(_ sender: UIButton) {
        calculator.clearAll()
        updateUI()
    }

    // IBAction linked to remove button and removeEntry method, clears the last element
    @IBAction func removeLastEntry(_ sender: UIButton) {
        guard calculator.hasResult == false else {
            return presentAlert(with: "Start a new operation !")
        }

        guard calculator.display != "" else {
            return presentAlert(with: "Start a new operation !")
        }
        calculator.removeEntry()
        updateUI()
    }

    // IBAction linked to all numberButtons, adds the number to the textView matching the button's title
    @IBAction func tappedNumberButton(_ sender: UIButton) {
        guard let numberText = sender.title(for: .normal) else {
            return
        }
        calculator.addNumber(numberText)
        updateUI()
    }

    // IBAction linked to all operatorsButton, adds the operator to the textView matching the button's title
    @IBAction func tappedOperatorButton(_ sender: UIButton) {
        guard let operatorText = sender.title(for: .normal) else {
            return
        }

        guard calculator.canAddOperator else {
                    return presentAlert(with: "An operator as already been added !")

        }
        calculator.addOperator(operatorText)
        updateUI()
    }

    // IBAction linked to the "=" button, computes operations and displays result at the end of the textView
    @IBAction func tappedEqualButton(_ sender: UIButton) {
        guard calculator.expressionIsCorrect else {
            return presentAlert(with: "Your expression isn't valid !")
        }

        guard calculator.hasEnoughElements else {
            return presentAlert(with: "Start a new operation !")
        }

        guard !calculator.isImpossibleToDivide else {
            return presentAlert(with: "Impossible to divide by nothing !")
        }
        calculator.compute()
        updateUI()
    }

    // Method used only in the controller to present different error messages depending on the situation
    fileprivate func presentAlert(with message: String) {
        let alertVC = UIAlertController(
            title: "Error",
            message: message,
            preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return self.present(alertVC, animated: true, completion: nil)
    }
}
