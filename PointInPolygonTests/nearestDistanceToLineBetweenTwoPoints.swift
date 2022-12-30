//
//  nearestDistanceToLineBetweenTwoPoints.swift
//  PointInPolygonTests
//
//  Created by Artemy Ozerski on 30/12/2022.
//

import XCTest
@testable import PointInPolygon

final class nearestDistanceToLineBetweenTwoPoints: XCTestCase {

    var sut : PointInPolygonSolver!

    override func setUpWithError() throws {
        sut =  PointInPolygonSolver()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testDist1() throws {
        let p1 = Point(x: 0, y: 0)
        let p2 = Point(x: 2, y: 0)
        let pToCheck = Point(x: 1, y: 1)
        let result = sut.nearestDistanceToLineBetweenTwoPoints(a: p1,
                                                               b: p2,
                                                               pointToCheck: pToCheck)
        XCTAssertEqual(result, 1)
    }



}
