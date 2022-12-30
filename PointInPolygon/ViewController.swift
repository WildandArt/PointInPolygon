//
//  ViewController.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 29/12/2022.
//

import UIKit
struct Polygons {
    static let concaveQuadrilateral = [
        Point(x: 2.20, y: 4.09),
        Point(x: 6.09, y: 5.80),
        Point(x: 4.78, y: 3.45),
        Point(x: 3.91, y: 0.20),
    ]
}
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       var solve = PointInPolygonSolver()
        var result = solve.triangulate(vertices: Polygons.concaveQuadrilateral)
    }


}

