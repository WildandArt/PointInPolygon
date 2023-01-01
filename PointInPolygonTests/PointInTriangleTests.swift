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
    static let triangle1 = [
        Point(x: 6.09, y: 5.80),
        Point(x: 2.03, y: 2.54),
        Point(x: 6.88, y: 0.66),
    ]
    static let triangle3 = [
        Point(x: -64.14, y: 31.57),
        Point(x: 58.09, y: 40.19),
        Point(x: 6.88, y: 0.66),
    ]
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
        XCTAssertTrue(sut.isPointInTriangle2(pointInCheck: pointInside,
                                            aPoint: a,
                                            bPoint: b,
                                            cPoint: c)
        )
    }
    func testPointInsideTriangle2() throws {
        //given
        let a = Point(x: 2.20, y: 4.09)
        let b = Point(x: 6.09, y: 5.80)
        let c = Point(x: 3.91, y: 0.20)

        let pointInside = Point(x: 4.78, y: 3.45)
        //when

        //test
        XCTAssertTrue(sut.isPointInTriangle2(pointInCheck: pointInside,
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
        let result = sut.isPointInTriangle2(
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
        let result = sut.isPointInTriangle2(
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
        let result = sut.isPointInTriangle2(
            pointInCheck: pointOnBorder,
            aPoint: a,
            bPoint: b,
            cPoint: c)
        //test
        XCTAssertTrue(result)
    }
    func testOutsideTriangle1(){
        let a = abc.triangle1[0]
        let b = abc.triangle1[1]
        let c = abc.triangle1[2]
        let p = Point(x: 0, y: 0)
        let result = sut.isPointInTriangle2(pointInCheck: p,
                                           aPoint: a,
                                           bPoint: b,
                                           cPoint: c)
        XCTAssertFalse(result)
    }
//    func testOnVertexTriangle1(){
//        let a = abc.triangle1[0]
//        let b = abc.triangle1[1]
//        let c = abc.triangle1[2]
//        let p = abc.triangle1[0]
//        let result = sut.isPointInTriangle2(pointInCheck: p,
//                                           aPoint: a,
//                                           bPoint: b,
//                                           cPoint: c)
//        XCTAssertFalse(result)
//    }
    func testOutsideTriangle3(){
        let a = abc.triangle3[0]
        let b = abc.triangle3[1]
        let c = abc.triangle3[2]
        let p = Point(x: 35, y: 20)
        let result = sut.isPointInTriangle2(pointInCheck: p,
                                           aPoint: a,
                                           bPoint: b,
                                           cPoint: c)
        XCTAssertFalse(result)
    }
    func testInsideTriangle3(){
        let a = abc.triangle3[0]
        let b = abc.triangle3[1]
        let c = abc.triangle3[2]
        let p = Point(x: 0, y: 20)
        let result = sut.isPointInTriangle2(pointInCheck: p,
                                           aPoint: a,
                                           bPoint: b,
                                           cPoint: c)
        XCTAssertTrue(result)
    }
    func testOnVertexTriangle3(){
        let a = abc.triangle3[0]
        let b = abc.triangle3[1]
        let c = abc.triangle3[2]
        let result = sut.isPointInTriangle2(pointInCheck: a,
                                           aPoint: a,
                                           bPoint: b,
                                           cPoint: c)
        XCTAssertTrue(result)
    }



//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
