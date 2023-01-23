//
//  Calculator.swift
//  CountOnMe
//
//  Created by Maxime Girard on 19/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

    var display: String = ""
    var elements: [String] {
        return display.split(separator: " ").map { "\($0)" }
    }
    var hasResult: Bool {
        return display.firstIndex(of: "=") != nil
    }
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-"
    }
    var hasEnoughElements: Bool {
        return elements.count >= 3
    }

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    func addNumber(_ number: String) {
        if hasResult {
            display = ""
        }
        display.append(number)
    }

    func addOperator(_ newOperator: String) {
        if canAddOperator {
//            display += " \(newOperator) "
            display.append(" \(newOperator) ")
        } else {
            print("Cannot add another operator.")
        }
    }

    func compute() {
        var operationsToReduce = elements

        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Int(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Int(operationsToReduce[2])!

            let result: Int
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: fatalError("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result)", at: 0)
        }
        display.append(" = \(operationsToReduce.first!)")
    }
}
