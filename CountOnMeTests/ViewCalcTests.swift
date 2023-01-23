//
//  ViewCalcTests.swift
//  CountOnMeTests
//
//  Created by Maxime Girard on 23/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import XCTest
@testable import CountOnMe

final class ViewCalcTests: XCTestCase {
    // MARK: - Properties
    var controller: ViewController!

    // MARK: - Setup
    override func setUp() {
        super.setUp()
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        controller = storyboard.instantiateInitialViewController() as! ViewController
    }
    
    override func tearDown() {
            super.tearDown()

            controller = nil
        }

    // MARK: - Tests
    func testGivenDisplayIsEmpty_WhenTappingNumberButton_ThenDisplayContainsTheNumberOfButton() {
        let _ = controller.view
        controller.tappedNumberButton(controller.numberButtons[1])

        XCTAssertEqual(controller.textView.text, "1")
    }

}
