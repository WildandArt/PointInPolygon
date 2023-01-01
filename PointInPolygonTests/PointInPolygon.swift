//
//  PointInPolygon.swift
//  PointInPolygonTests
//
//  Created by Artemy Ozerski on 01/01/2023.
//

import XCTest
@testable import PointInPolygon

final class PointInPolygon: XCTestCase {
    var sut : PointInPolygonSolver!

    override func setUpWithError() throws {
        sut = PointInPolygonSolver()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    func testIsInTriangle() throws {
        let triangle = abc.triangle
        let pointInside = Point(x: 3, y: 3.0)
        let result = sut.isPointInPolygon(vertices: triangle, pointToCheck: pointInside)
        XCTAssertTrue(result)
    }
    func testIsInTriangle1() throws {
        let triangle = Polygons.triangle1

        let pointTocheck = Point(x: 6.09, y: 5.80)
        let result = sut.isPointInPolygon(vertices: triangle, pointToCheck: pointTocheck)
        XCTAssertTrue(result)
    }
    func testIsOutsideConcaveQuadrilateral() throws {
        let concaveQuadrilateral = Polygons.concaveQuadrilateral
        let pointOutside = Point(x: 7, y: 8)
        let result = sut.isPointInPolygon(vertices: concaveQuadrilateral, pointToCheck: pointOutside)
        XCTAssertFalse(result)
    }
    func testIsInsideConcaveQuadrilateral() throws {
        let concaveQuadrilateral = Polygons.concaveQuadrilateral
        let pointInside = Point(x: 3.91, y: 1.0)
        let result = sut.isPointInPolygon(vertices: concaveQuadrilateral,
                                          pointToCheck: pointInside)
        XCTAssertTrue(result)
    }
    func testOnVertexConcaveQuadrilateral() throws {
        let concaveQuadrilateral = Polygons.concaveQuadrilateral
        let pointOutside = Point(x: concaveQuadrilateral[0].x, y: concaveQuadrilateral[1].y)
        let result = sut.isPointInPolygon(vertices: concaveQuadrilateral, pointToCheck: pointOutside)
        XCTAssertFalse(result)
    }



}
