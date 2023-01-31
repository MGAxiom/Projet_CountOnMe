//
//  Calculator.swift
//  CountOnMe
//
//  Created by Maxime Girard on 19/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

    // Show an operation on app launch and inits display
    var display: String = "1 + 1 = 2"

    // Seperates the display into different elements "1 + 1" becomes "1" "+" "1"
    var elements: [String] {
        return display.split(separator: " ").map { "\($0)" }
    }

    // Returns true if display already has been given a result by checking if "=" is there
    var hasResult: Bool {
        return display.firstIndex(of: "=") != nil
    }

    // Returns true if "÷" and "0" are associated
    var isImpossibleToDivide: Bool {
        return display.contains(" ÷ 0")
    }

    // Returns true if an operator or equal is the last element being added or present
    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷" && !hasResult
    }

    // Returns true if the number of elements is equal or greater than 3, minimum required to compute
    var hasEnoughElements: Bool {
        return elements.count >= 3
    }

    // Returns true if the last element is not an operator and therefore can be computed
    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    // Method to remove everything present in the display
    func clearAll() {
        display.removeAll(keepingCapacity: true)
    }

    // Method to remove the last element from display or if it's an operator remove it and its whitespaces
    func removeEntry() {
        if elements.last == "+" || elements.last == "-" || elements.last == "×" || elements.last == "÷" {
            display.removeLast(3)
        } else {
            display.removeLast()
        }
    }

        // Method used to add a number using the UIButton's title, removes everything from display if it already has a result
        func addNumber(_ number: String) {
            if hasResult {
                display = ""
            }
            display.append(number)
        }

        // Method used to add an operator using the UIButton's title, whitespaces are added left and right of the operator
        func addOperator(_ newOperator: String) {
            display.append(" \(newOperator) ")
        }

    // Method used to compute any valid operation, iterates over the elements, first computing operation(s) with "÷" and "×", then "+" and "-"
    func compute() {
        var operationsToReduce = elements
        let possibleOperands = [["÷", "×"], ["+", "-"]]

        for operands in possibleOperands {
            while let operandIndex = operationsToReduce.firstIndex(where: {operands.contains($0)}) {
                let left = Double(operationsToReduce[operandIndex-1])!
                let right = Double(operationsToReduce[operandIndex+1])!

                var result: Double = 0
                switch operationsToReduce[operandIndex] {
                case "÷": result = left / right
                case "×": result = left * right
                case "+": result = left + right
                case "-": result = left - right
                default: break
                }

                operationsToReduce.replaceSubrange((operandIndex-1)...(operandIndex+1), with: ["\(result.clean)"])
                print(operationsToReduce)
            }
        }
        display.append(" = \(operationsToReduce.first!)")
    }
}
