//
//  AngleCheck.swift
//  PointInPolygonTests
//
//  Created by Artemy Ozerski on 30/12/2022.
//

import XCTest
@testable import PointInPolygon
struct Angle{
    static let oneEighty = [Point(x: 1.81, y: 3.77),
                            Point(x: 4.03, y: 3.68),
                            Point(x: 6.10, y: 3.59)
    ]
    static let twoZeroThree = [
        Point(x: 4.62, y: 3.61),//center
        Point(x: 6.09, y: 5.80),//right
        Point(x: 3.91, y: 0.20)//left
    ]
    static let fortySeven = [
        Point(x: 6.09, y: 5.80),
        Point(x: 6.32, y: 2.89),
        Point(x: 9.06, y: 3.44)
    ]
    static let oneNineFour = [
        Point(x: 4.78, y: 3.45),
        Point(x: 6.09, y: 5.80),
        Point(x: 3.91, y: 0.20)
    ]

}
final class AngleCheck: XCTestCase {
    var sut : PointInPolygonSolver!

    override func setUpWithError() throws {
        sut = PointInPolygonSolver()

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testAngleIs180() throws {
        let va = Angle.oneEighty[1]
        let vb = Angle.oneEighty[0]
        let vc = Angle.oneEighty[2]
        let result = sut.angleIsMoreThan180(va: va,
                                            vb: vb,
                                            vc: vc)
        XCTAssertFalse(result)

    }
    func testAngleIs203() throws {
        let va = Angle.twoZeroThree[0]
        let vb = Angle.twoZeroThree[1]
        let vc = Angle.twoZeroThree[2]
        let result = sut.angleIsMoreThan180(va: va,
                                            vb: vb,
                                            vc: vc)
        XCTAssertTrue(result)
    }
    func testAngleIs47() throws {
        let va = Angle.fortySeven[0]
        let vb = Angle.fortySeven[1]
        let vc = Angle.fortySeven[2]
        let result = sut.angleIsMoreThan180(
            va: va,
            vb: vb,
            vc: vc)
        XCTAssertFalse(result)
    }
    func testAngleIs194() throws {
        let va = Angle.oneNineFour[0]
        let vb = Angle.oneNineFour[1]
        let vc = Angle.oneNineFour[2]
        let result = sut.angleIsMoreThan180(va: va,
                                            vb: vb,
                                            vc: vc)
        XCTAssertTrue(result)
    }




}
