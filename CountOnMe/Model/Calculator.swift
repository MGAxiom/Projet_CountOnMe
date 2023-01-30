//
//  Calculator.swift
//  CountOnMe
//
//  Created by Maxime Girard on 19/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculator {

    var display: String = "1 + 1 = 2"
    var elements: [String] {
        return display.split(separator: " ").map { "\($0)" }
    }

    var hasResult: Bool {
        return display.firstIndex(of: "=") != nil
    }

    var isImpossibleToDivide: Bool {
        return display.contains(" ÷ 0")
    }

    var canAddOperator: Bool {
        return elements.last != "+" && elements.last != "-" && elements.last != "×" && elements.last != "÷"
    }

    var hasEnoughElements: Bool {
        return elements.count >= 3
    }

    var expressionIsCorrect: Bool {
        return elements.last != "+" && elements.last != "-"
    }

    func clearAll() {
        display.removeAll(keepingCapacity: true)
    }

    func removeEntry() {
        if elements.last == "+" || elements.last == "-" || elements.last == "×" || elements.last == "÷" {
            display.removeLast(3)
        } else {
            display.removeLast()
        }
    }

        func addNumber(_ number: String) {
            if hasResult {
                display = ""
            }
            display.append(number)
        }

        func addOperator(_ newOperator: String) {
            display.append(" \(newOperator) ")
        }

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
