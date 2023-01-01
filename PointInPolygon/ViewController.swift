//
//  ViewController.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 29/12/2022.
//

import UIKit
struct Polygons{
    static let triangle1 = [
        Point(x: 6.09, y: 5.80),
        Point(x: 2.03, y: 2.54),
        Point(x: 6.88, y: 0.66),
    ]
    static let triangle2 = [
        Point(x: -4.38, y: 4.11),
        Point(x: -3.74, y: -2.01),
        Point(x: 6.88, y: 0.66),
    ]
    static let triangle3 = [
        Point(x: -64.14, y: 31.57),
        Point(x: 58.09, y: 40.19),
        Point(x: 6.88, y: 0.66),
    ]
    static let concaveQuadrilateral = [
        Point(x: 2.20, y: 4.09),
        Point(x: 6.09, y: 5.80),
        Point(x: 4.78, y: 3.45),
        Point(x: 3.91, y: 0.20),
    ]
    static let concavePentagon = [
        Point(x: -6.21, y: 11.66),
        Point(x: 6.09, y: 5.80),
        Point(x: 4.78, y: 3.45),
        Point(x: 3.91, y: 0.20),
        Point(x: 3.91, y: 0.20)
    ]
}
struct abc {
    static let triangle : [Point] = [Point(x: 1.38, y: 2.78),
                           Point(x: 6.50, y: 6.92),
                           Point(x: 7.53, y: 0.42)]
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       var solve = PointInPolygonSolver()
        //var result = solve.triangulate(vertices: Polygons.concaveQuadrilateral)

//        let result = solve.isPointInPolygon(vertices: Polygons.triangle1,
//                                            pointToCheck: pointInside)
//        print(result)
    }


}

