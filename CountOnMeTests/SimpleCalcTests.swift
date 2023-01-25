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

    func testGivenDisplayIsEmpty_WhenAddingNumber_ThenDisplayContainsOnlyTheNumber() {
        calc.addNumber("1")

        XCTAssertEqual(calc.display, "1")
    }

    func testGivenDisplayIsNotEmptyAndHavingResult_WhenAddingNumber_ThenDisplayCountainsTheNumber() {
        calc.display = "2+3=5"

        calc.addNumber("1")

        XCTAssertEqual(calc.display, "1")
    }

    func testGivenDisplayIsNotEmptyAndHasNoResult_WhenAddingNumber_ThenDisplayCountainsTheNumber() {
        calc.display = "1"

        calc.addNumber("2")

        XCTAssertEqual(calc.display, "12")

        calc.display = "1+"

        calc.addNumber("2")

        XCTAssertEqual(calc.display, "1+2")
    }

    func testGivenDisplayIsNotemptyAndHasNumber_WhenAddingOperator_ThenDisplayCountainsTheNumberAndTheOperator() {
        calc.display = "1"

        calc.addOperator("+")

        XCTAssertEqual(calc.display, "1 + ")
    }

    func testGivenDisplayIsNotemptyAndHasNumberAndOperator_WhenCheckingNumberOfElements_ThenElementNumberEquelTwo() {
        calc.display = "1 + "

        XCTAssertEqual(calc.elements.count, 2)
    }

    func testGivenDisplayIsNotEmptyAndHasNumberAndAnOperator_WhenCheckingIfItCanGetOperator_ThenItCannotHaveAnotherOperator() {
        calc.display = "1 + "

        XCTAssertEqual(calc.canAddOperator, false)
        
        calc.display = "1 - "

        XCTAssertEqual(calc.canAddOperator, false)
        
        calc.display = "1 × "

        XCTAssertEqual(calc.canAddOperator, false)
        
        calc.display = "1 ÷ "

        XCTAssertEqual(calc.canAddOperator, false)
    }

    func testGivenDisplayIsNotEmptyAndHasNumberAndAnOperator_WhenAddingOperator_ThenDisplayCannotHaveNewOperator() {
        calc.display = "1 + "

        calc.addOperator("+")

        XCTAssertNotEqual(calc.display, "1 + + ")
    }

    func testGivenDisplayIsNotEmptyAndHasNumberAndAnOperator_WhenAddingEqual_ThenDisplayShouldBeCorrect() {
        calc.addNumber("1")
        calc.addOperator("+")
        calc.addNumber("2")

        XCTAssertTrue(calc.expressionIsCorrect)
    }

    func testGivenDisplayIsNotEmptyAndHasNumbersAndAnOperator_WhenTryingToGetResult_ThenDisplayShouldHaveEnoughElements() {
        calc.display = "1 + 2"

        XCTAssertEqual(calc.hasEnoughElements, true)
    }

    func testGivenDisplayIsNotEmptyAndHasNumbersAndAnOperator_WhenAskingForResult_ThenHasResult() {
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
}
