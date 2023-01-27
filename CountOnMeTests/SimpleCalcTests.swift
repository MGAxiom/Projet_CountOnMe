//
//  SimpleCalcTests.swift
//  SimpleCalcTests
//
//  Created by Vincent Saluzzo on 29/03/2019.
//  Copyright © 2019 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

class SimpleCalcTests: XCTestCase {
    // MARK: - Properties
    var calc: Calculator!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        calc = Calculator()
    }

    // MARK: - Tests
//    func testInit() {
//
//        XCTAssertEqual(calc.display, "")
//        XCTAssertFalse(calc.hasResult)
//    }

    func testAddingNewNumber() {
        calc.addNumber("1")

        XCTAssertEqual(calc.display, "1")
    }

    func testDisplayEmptiesAfterResult() {
        calc.display = "2+3=5"

        calc.addNumber("1")

        XCTAssertEqual(calc.display, "1")
    }

    func testAddingNewNumbers() {
        calc.display = "1"

        calc.addNumber("2")

        XCTAssertEqual(calc.display, "12")

        calc.display = "1+"

        calc.addNumber("2")

        XCTAssertEqual(calc.display, "1+2")
    }

    func testNewOperatorBeingDisplayed() {
        calc.display = "1"

        calc.addOperator("+")

        XCTAssertEqual(calc.display, "1 + ")
    }

    func testDisplayUnderstandsElements() {
        calc.display = "1 + "

        XCTAssertEqual(calc.elements.count, 2)
    }

    func testDisplayCannotDivideByNothing() {
        calc.display = "1 ÷ 0"

        XCTAssertTrue(calc.isImpossibleToDivide)
    }

    func testCannotHaveTwoOperators() {
        calc.display = "1 + "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 - "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 × "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 ÷ "

        XCTAssertEqual(calc.canAddOperator, false)
    }

    func testAddingNewOperator() {
        calc.display = "1 + "

        calc.addOperator("+")

        XCTAssertNotEqual(calc.display, "1 + + ")
    }

    func testDisplayExpressionIsCorrect() {
        calc.addNumber("1")
        calc.addOperator("+")
        calc.addNumber("2")

        XCTAssertTrue(calc.expressionIsCorrect)
    }

    func testDisplayHasEnoughElements() {
        calc.display = "1 + 2"

        XCTAssertEqual(calc.hasEnoughElements, true)
    }

    func testDisplayHasResult() {
        calc.display = "1 + 2"

        calc.compute()

        XCTAssertEqual(calc.display, "1 + 2 = 3")

        calc.display = "2 - 1"

        calc.compute()

        XCTAssertEqual(calc.display, "2 - 1 = 1")

        calc.display = "2 × 1"

        calc.compute()

        XCTAssertEqual(calc.display, "2 × 1 = 2.0")

        calc.display = "2 ÷ 1"

        calc.compute()

        XCTAssertEqual(calc.display, "2 ÷ 1 = 2.0")
    }

    func testDisplayCanRemoveElements() {
        calc.display = "10 + 100"

        calc.removeEntry()

        XCTAssertEqual(calc.display, "10 + 10")
    }

    func testDisplayHasLostAllElements() {
        calc.display = "10 + 500"

        calc.clearAll()

        XCTAssertEqual(calc.display, "")
    }
}
