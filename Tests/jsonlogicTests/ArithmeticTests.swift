//
//  Arithmetic.swift
//  jsonlogicTests
//
//  Created by Christos Koninis on 11/02/2019.
//

import XCTest
@testable import jsonlogic

class Arithmetic: XCTestCase {

    func testAddition() {
        var rule =
        """
        { "+" : [4, 2] }
        """
        XCTAssertEqual(6, try applyRule(rule, to: nil))

        rule =
        """
        { "+" : [4, "2"] }
        """
        XCTAssertEqual(6, try applyRule(rule, to: nil))

        rule =
        """
        { "+" : [2, 2, 2, 2, 2]}
        """
        XCTAssertEqual(10, try applyRule(rule, to: nil))

        rule =
        """
        { "+" : "3.14"}
        """
        XCTAssertEqual(3.14, try applyRule(rule, to: nil))
    }

    func testSubtraction() {
        var rule =
                """
                { "-" : [4, 2] }
                """
        XCTAssertEqual(2, try applyRule(rule, to: nil))

        rule =
                """
                { "-" : [2, 3] }
                """
        XCTAssertEqual(-1, try applyRule(rule, to: nil))

        rule =
                """
                { "-" : [3] }
                """
        XCTAssertEqual(-3, try applyRule(rule, to: nil))

        rule =
                """
                 { "-" : [1, "1"] }
                """
        XCTAssertEqual(0, try applyRule(rule, to: nil))
    }

    func testMultiplication() {
        var rule =
                """
                { "*" : [4, 2] }
                """
        XCTAssertEqual(8, try applyRule(rule, to: nil))

        rule =
                """
                { "*" : [2, 2, 2, 2, 2]}
                """
        XCTAssertEqual(32, try applyRule(rule, to: nil))

        rule =
                """
                { "*" : [3, 2] }
                """
        XCTAssertEqual(6, try applyRule(rule, to: nil))

        rule =
                """
                { "*" : [1]}
                """
        XCTAssertEqual(1, try applyRule(rule, to: nil))

        rule =
                """
                { "*" : ["1", 1]}
                """
        XCTAssertEqual(1, try applyRule(rule, to: nil))
    }

    func testMultiplication_TypeCoercion() {
        var rule =
        """
        {"*":["2","2"]}
        """
        XCTAssertEqual(4, try applyRule(rule, to: nil))

        rule =
        """
        {"*":["2"]}
        """
        XCTAssertEqual(2, try applyRule(rule, to: nil))
    }

    func testDivision() {
        var rule =
        """
        { "/" : [4, 2]}
        """
        XCTAssertEqual(2, try applyRule(rule, to: nil))

        rule =
        """
        { "/" : [2, 4]}
        """
        XCTAssertEqual(0.5, try applyRule(rule, to: nil))

        rule =
        """
        { "+" : [2, 2, 2, 2, 2]}
        """
        XCTAssertEqual(10, try applyRule(rule, to: nil))

        rule =
        """
        { "/" : ["1", 1]}
        """
        XCTAssertEqual(1, try applyRule(rule, to: nil))
    }

    func testModulo() {
        var rule =
                """
                { "%" : [1, 2]}
                """
        XCTAssertEqual(1, try applyRule(rule, to: nil))

        rule =
                """
                { "%" : [2, 2]}
                """
        XCTAssertEqual(0, try applyRule(rule, to: nil))

        rule =
                """
                { "%" : [3, 2]}
                """
        XCTAssertEqual(1, try applyRule(rule, to: nil))
    }

    func testUnaryMinus() {
        var rule =
                """
                { "-" : [2] }
                """
        XCTAssertEqual(-2, try applyRule(rule, to: nil))

        rule =
                """
                { "-" : [-2] }
                """
        XCTAssertEqual(2, try applyRule(rule, to: nil))
    }
    
    func testSin() {
        var rule =
                """
                { "sin": [\(Double.pi / 2)] }
                """
        
        XCTAssertEqual(1, try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
                """
                { "sin": [\(Double.pi / 6)] }
                """
        
        XCTAssertEqual(0.5, try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
                """
                { "sin": [\(Double.pi)] }
                """
        
        XCTAssertEqual(0, try applyRule(rule, to: nil), accuracy: 0.002)
    }
    
    func testCos() {
        var rule =
                """
                { "cos": [\(Double.pi / 2)] }
                """
        
        XCTAssertEqual(0, try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
                """
                { "cos": [\(Double.pi / 3)] }
                """
        
        XCTAssertEqual(0.5, try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
                """
                { "cos": [\(2 * Double.pi)] }
                """
        
        XCTAssertEqual(1, try applyRule(rule, to: nil), accuracy: 0.002)
    }
    
    func testTan() {
        var rule =
        """
        { "tan": [0] }
        """
        
        XCTAssertEqual(0, try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
        """
        { "tan": [\(Double.pi / 3)] }
        """
        
        XCTAssertEqual(sqrt(3), try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
        """
        { "tan": [\(Double.pi / 4)] }
        """
        
        XCTAssertEqual(1, try applyRule(rule, to: nil), accuracy: 0.002)
        
        rule =
        """
        { "tan": [\(Double.pi / 2)] }
        """
        
        // In mathematics, this would be undefined
        // In a programming language using IEEE 754, this is "a very large number"
        XCTAssertGreaterThan(try applyRule(rule, to: nil), 1.5e16)
    }
}
