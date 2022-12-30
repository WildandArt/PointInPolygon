//
//  TriangulateTests.swift
//  PointInPolygonTests
//
//  Created by Artemy Ozerski on 30/12/2022.
//

import XCTest
@testable import PointInPolygon

struct Polygons{
    static let triangle = [
        Point(x: 6.09, y: 5.80),
        Point(x: 2.03, y: 2.54),
        Point(x: 6.88, y: 0.66),
    ]
    static let triangle2 = [
        Point(x: -4.38, y: 4.11),
        Point(x: -3.74, y: -2.01),
        Point(x: 6.88, y: 0.66),
    ]
    static let concaveQuadrilateral = [
        Point(x: 2.20, y: 4.09),
        Point(x: 6.09, y: 5.80),
        Point(x: 4.78, y: 3.45),
        Point(x: 3.91, y: 0.20),
    ]
}
final class TriangulateTests: XCTestCase {
    var sut : PointInPolygonSolver!

    override func setUpWithError() throws {
        sut = PointInPolygonSolver()
    }

    override func tearDownWithError() throws {
       sut = nil
    }

    func testTriangleIsTriangulatable() throws {
        var given = Polygons.triangle
        var result = sut.triangulate(vertices: given)
        XCTAssertTrue(result)
    }
    func testConcaveQuadrilateralIsTriangulatable() throws{
        var given = Polygons.concaveQuadrilateral
        var result =  sut.triangulate(vertices: given)
        XCTAssertTrue(result)
    }



}
