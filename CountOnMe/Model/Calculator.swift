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
            display.remove
        } else {
            display.removeLast()
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

        for index in stride(from: operationsToReduce.count-2, to: 0, by: -1) {
            if operationsToReduce[index] == "×" || operationsToReduce[index] == "÷" {

                let left = Double(operationsToReduce[index-1])!
                let operand = operationsToReduce[index]
                let right = Double(operationsToReduce[index+1])!

                var result: Double = 0
                switch operand {
                case "×": result = left * right
                case "÷": result = left / right
                default: print("Unknown operator !")
                }

                operationsToReduce.remove(at: index+1)
                operationsToReduce.remove(at: index)
                operationsToReduce.remove(at: index-1)
                operationsToReduce.insert("\(result)", at: index-1)
            }
        }
        // Iterate over operations while an operand still here
        while operationsToReduce.count > 1 {
            let left = Double(operationsToReduce[0])!
            let operand = operationsToReduce[1]
            let right = Double(operationsToReduce[2])!

            var result: Double = 0
            switch operand {
            case "+": result = left + right
            case "-": result = left - right
            default: print("Unknown operator !")
            }

            operationsToReduce = Array(operationsToReduce.dropFirst(3))
            operationsToReduce.insert("\(result.clean)", at: 0)
        }
        display.append(" = \(operationsToReduce.first!)")
    }
}
