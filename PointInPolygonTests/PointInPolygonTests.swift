//
//  PointInPolygonTests.swift
//  PointInPolygonTests
//
//  Created by Artemy Ozerski on 29/12/2022.
//

import XCTest
@testable import PointInPolygon
struct abc {
    static let triangle : [Point] = [Point(x: 1.38, y: 2.78),
                           Point(x: 6.50, y: 6.92),
                           Point(x: 7.53, y: 0.42)]
}
final class PointInPolygonTests: XCTestCase {
    var sut : PointInPolygonSolver!

    override func setUpWithError() throws {
        sut = PointInPolygonSolver()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testPointInsideTriangle() throws {
        //given
        let a = abc.triangle[0]
        let b = abc.triangle[1]
        let c = abc.triangle[2]

        let pointInside = Point(x: 3, y: 3.0)
        //when

        //test
        XCTAssertTrue(sut.isPointInTriangle(pointInCheck: pointInside,
                                            aPoint: a,
                                            bPoint: b,
                                            cPoint: c)
        )
    }
    func testPointOutsideTriangle() throws {
        //given
        let a = abc.triangle[0]
        let b = abc.triangle[1]
        let c = abc.triangle[2]
        let pointOutside = Point(x: 4, y: 6)
        //when
        let result = sut.isPointInTriangle(
            pointInCheck: pointOutside,
            aPoint: a,
            bPoint: b,
            cPoint: c)
        //test
        XCTAssertFalse(result)
    }
    func testPointOnVertexTriangle() throws {
        //given
        let a = abc.triangle[0]
        let b = abc.triangle[1]
        let c = abc.triangle[2]
        let pointOnVertex = abc.triangle[2]
        //when
        let result = sut.isPointInTriangle(
            pointInCheck: pointOnVertex,
            aPoint: a,
            bPoint: b,
            cPoint: c)
        //test
        XCTAssertTrue(result)
    }
    func testPointOnBorderTriangle() throws {
        //given
        let a = abc.triangle[0]
        let b = abc.triangle[1]
        let c = abc.triangle[2]
        let pointOnBorder = Point(x: 3, y: 4.08991)
        //when
        let result = sut.isPointInTriangle(
            pointInCheck: pointOnBorder,
            aPoint: a,
            bPoint: b,
            cPoint: c)
        //test
        XCTAssertTrue(result)
    }


//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
