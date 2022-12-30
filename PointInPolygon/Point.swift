//
//  Point.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 29/12/2022.
//

import Foundation
struct Point{
    let x : Double
    let y : Double

    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }

    static func +(left: Point, right: Point) ->Point{
        let x = left.x + right.x
        let y = left.y + right.y
        return Point(x: x, y: y)
        }
    static func -(left: Point, right: Point) ->Point{
        let x = left.x - right.x
        let y = left.y - right.y
        return Point(x: x, y: y)
        }
}
