//
//  crossProduct.swift
//  PointInPolygonTests
//
//  Created by Artemy Ozerski on 30/12/2022.
//

import XCTest
@testable import PointInPolygon
var sut : PointInPolygonSolver!
struct CrossProductMock{
    static let positive = [
        Point(x: 3, y: 0),
        Point(x: -0.23, y: 1.49),
    ]
    static let negative = [
        Point(x: 3, y: 0),
        Point(x: -0.95, y: -0.2),
    ]
    static let zero = [
        Point(x: 3, y: 0),
        Point(x: -2, y: 0),
    ]
}

final class crossProduct: XCTestCase {

    override func setUpWithError() throws {
       sut = PointInPolygonSolver()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testPositive() throws {
        let result = sut.crossProduct(
            vec1: CrossProductMock.positive[0],
            vec2: CrossProductMock.positive[1])
        XCTAssertTrue(result > 0)
    }
    func testNegative() throws {
        let result = sut.crossProduct(
            vec1: CrossProductMock.negative[0],
            vec2: CrossProductMock.negative[1])
        XCTAssertEqual(result, -0.59, accuracy: .greatestFiniteMagnitude)
    }

    func testZero(){
        let result = sut.crossProduct(
            vec1: CrossProductMock.zero[0],
            vec2: CrossProductMock.zero[1])
        XCTAssertEqual(result, 0, accuracy: .greatestFiniteMagnitude)
    }

}
