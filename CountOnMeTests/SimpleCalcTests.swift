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

    func testAddingNewNumberIsDisplayed() {
        calc.display = ""

        calc.addNumber("1")

        XCTAssertEqual(calc.display, "1")
    }

    func testDisplayEmptiesAfterResult() {
        calc.display = "2 + 3 = 5"

        calc.addNumber("1")

        XCTAssertEqual(calc.display, "1")
    }

    func testAddingNewNumberAfterNumberOrOperator() {
        calc.display = "1"

        calc.addNumber("2")

        XCTAssertEqual(calc.display, "12")

        calc.display = "1 + "

        calc.addNumber("2")

        XCTAssertEqual(calc.display, "1 + 2")
    }

    func testNewOperatorBeingAddedAndDisplayed() {
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

    func testCannotHaveTwoOperatorsNextToEachOther() {
        calc.display = "1 + "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 - "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 × "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 ÷ "

        XCTAssertEqual(calc.canAddOperator, false)

        calc.display = "1 + 1 = 2"

        XCTAssertEqual(calc.canAddOperator, false)
    }

    func testAddingNewOperatorNotAddedAfterOtherOperator() {
        calc.display = "1 + "

        calc.addOperator("+")

        XCTAssertNotEqual(calc.display, "1 + + ")
    }

    func testDisplayUnderstandsWhenExpressionIsCorrect() {
        calc.addNumber("1")
        calc.addOperator("+")
        calc.addNumber("2")

        XCTAssertTrue(calc.expressionIsCorrect)
    }

    func testDisplayHasEnoughElements() {
        calc.display = "1 + 2"

        XCTAssertEqual(calc.hasEnoughElements, true)
    }

    func testDisplayUnderstandsResultConcept() {
        calc.display = "1 + 2"

        calc.compute()

        XCTAssertEqual(calc.display, "1 + 2 = 3")

        calc.display = "2 - 1"

        calc.compute()

        XCTAssertEqual(calc.display, "2 - 1 = 1")

        calc.display = "2 × 1"

        calc.compute()

        XCTAssertEqual(calc.display, "2 × 1 = 2")

        calc.display = "2 ÷ 1"

        calc.compute()

        XCTAssertEqual(calc.display, "2 ÷ 1 = 2")
    }

    func testCanRemoveOneElementFromDisplay() {
        calc.display = "10 + 100"

        calc.removeEntry()

        XCTAssertEqual(calc.display, "10 + 10")

        calc.display = "10 + "

        calc.removeEntry()

        XCTAssertEqual(calc.display, "10")
    }

    func testDisplayLosesAllElementsAtOnce() {
        calc.display = "10 + 500"

        calc.clearAll()

        XCTAssertEqual(calc.display, "")
    }

    func testOperatorPrecedence() {
        calc.display = "78 ÷ 12 ÷ 45"

        calc.compute()

        XCTAssertNotEqual(calc.display, "78 ÷ 12 ÷ 45 = 292.5")
    }
}
