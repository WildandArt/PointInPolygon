//
//  PointInPolygonSolver.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 29/12/2022.
//

import Foundation
//enum ErrorMsg {
//    case listIsEmpty = "the list of vertices is empty"
//}
class PointInPolygonSolver{
    var vertices : [Point]?

    func checkIfOutSideABoxOfPolygon(vertices : [Point], pointToCheck : Point)->Bool{
        if vertices.count < 3{
            print("not a polygon")
        }
        var maxHeight = vertices[0].y
        var leftSide = vertices[0].x
        var rightside = vertices[0].x
        var minBottom = vertices[0].y

        for i in 1..<vertices.count{
            if vertices[i].x < leftSide{
                leftSide = vertices[i].x
            }
            if vertices[i].x > rightside{
                rightside = vertices[i].x
            }
            if vertices[i].y > maxHeight{
                maxHeight = vertices[i].y
            }
            if vertices[i].y < minBottom{
                minBottom = vertices[i].y
            }
        }

        if  (pointToCheck.x) >= leftSide &&
            (pointToCheck.x) <= rightside &&
            (pointToCheck.y) <= maxHeight &&
            (pointToCheck.y) >= minBottom {
            return false
        }
        return true
    }
    func solve(vertices : [Point],
               pointToCheck : Point)-> String{

            if isPointInPolygon(vertices: vertices,
                                pointToCheck: pointToCheck){
                return "The point is inside a Polygon"

            }
        else{
            let res = findADistanceBetweenAPolygonAndPoint(vertices: vertices,
                                                 pointToCheck: pointToCheck)
            return "The point is outside and the minimal distance is: \(res)"
        }

    }

    func findADistanceBetweenAPolygonAndPoint(vertices : [Point],
                                       pointToCheck : Point
    )->Double{
        if vertices.count < 3{
            fatalError("wrong input")
        }
        let lastIdx = vertices.count - 1
        var min = nearestDistanceToLineBetweenTwoPoints(a: vertices[0],
                                                        b: vertices[lastIdx],
                                                        pointToCheck: pointToCheck)
        //find all the pairs
        for i in 0..<vertices.count - 1{
            var dist = nearestDistanceToLineBetweenTwoPoints(a: vertices[i],
                                                             b: vertices[i + 1],
                                                             pointToCheck: pointToCheck)
            if min > dist{
                min = dist
            }
        }

        return min
    }
    func isPointInPolygon(vertices : [Point],
                          pointToCheck : Point)->Bool{

        var triangles : [Int] = []
        var errorMsg : String = ""
        var indexList = Array(0...vertices.count - 1)

        if !isValidPolygon(vertices) {return false}
        if vertices.count == 3 {
            return isPointInTriangle(pointInCheck: pointToCheck,
                                      aPoint: vertices[0],
                                      bPoint: vertices[1],
                                      cPoint: vertices[2])
        }
        while indexList.count > 3{//if less than 3 we add the last to list of triangles

            for i in 0..<indexList.count{

                var isEar = true

                let a = indexList[i]
                let b = getItem(list: indexList, index: i - 1)
                let c = getItem(list: indexList, index: i + 1)

                let va = vertices[a]
                let vb = vertices[b]
                let vc = vertices[c]

                if angleIsMoreThan180(va: va, vb: vb, vc: vc){
                    continue
                }

                //check if a vertice is inside a triangle
                for j in 0..<vertices.count{
                    if j == a || j == b || j == c{
                        continue
                    }
                    let p = vertices[j]
                    if isPointInTriangle(pointInCheck: p,
                            aPoint: va,
                            bPoint: vc,
                            cPoint: vb) {
                        isEar = false
                        break
                    }
                }
                if isEar{
                    if isPointInTriangle(pointInCheck: pointToCheck,
                                         aPoint: va,
                                         bPoint: vc,
                                         cPoint: vb){
                        print("Found In Triangle = ([]")
                        return true
                    }
                    // add triangle to the list
                    triangles.append(a)
                    triangles.append(b)
                    triangles.append(c)
                    indexList.remove(at: i)

                    break
                }

            }
        }
        //left with 3 triangles
        if isPointInTriangle(pointInCheck: pointToCheck,
                             aPoint: vertices[indexList[0]],
                             bPoint: vertices[indexList[1]],
                             cPoint: vertices[indexList[2]]){
            print("Found In Triangle = ([]")
            return true
        }
        triangles.append(indexList[0])
        triangles.append(indexList[1])
        triangles.append(indexList[2])
        print("triangles : \(triangles), number of trinagles: \(triangles.count / 3) , number of vertices: \(vertices.count)")
        return false
    }


}
extension PointInPolygonSolver{
    func triangulate(vertices : [Point])->Bool{

        var triangles : [Int] = []
        var errorMsg : String = ""
        var indexList = Array(0...vertices.count - 1)

        if !isValidPolygon(vertices) {return false}

        while indexList.count > 3{//if less than 3 we add the last to list of triangles

            for i in 0..<indexList.count{

                var isEar = true

                let a = indexList[i]
                let b = getItem(list: indexList, index: i - 1)
                let c = getItem(list: indexList, index: i + 1)

                let va = vertices[a]
                let vb = vertices[b]
                let vc = vertices[c]

                if angleIsMoreThan180(va: va, vb: vb, vc: vc){
                    continue
                }

                //check if a vertice is inside a triangle
                for j in 0..<vertices.count{
                    if j == a || j == b || j == c{
                        continue
                    }
                    let p = vertices[j]
                    if isPointInTriangle(pointInCheck: p,
                                         aPoint: va,
                                         bPoint: vc,
                                         cPoint: vb) {
                        isEar = false
                        break
                    }
                }
                if isEar{
                    // add triangle to the list
                    triangles.append(a)
                    triangles.append(b)
                    triangles.append(c)
                    //erase index from the indexList
                    indexList.remove(at: i)
                    // check  if the Point of Interest is in a triangle
                    //start a loop all over again
                    break
                }

            }
        }
        //left with 3 triangles
        triangles.append(indexList[0])
        triangles.append(indexList[1])
        triangles.append(indexList[2])
        print("triangles : \(triangles), number of trinagles: \(triangles.count / 3) , number of vertices: \(vertices.count)")
        return true
    }
    func isValidPolygon(_ vertices : [Point])->Bool{
        if vertices.count < 3{
            return false
        }
        if vertices.count > 500{
            return false
        }
        return true
    }
    func angleIsMoreThan180(va : Point,
                            vb : Point,
                            vc : Point)-> Bool{
        let va_to_vb = vb - va
        let va_to_vc = vc - va
//        print("va_to_vb :\(va_to_vb)")
//        print("va_to_vc :\(va_to_vc)")

        return crossProduct(vec1: va_to_vb,
                            vec2: va_to_vc) < 0
    }
    func crossProduct(vec1 : Point,
                      vec2 : Point)-> Double{
        let result = (vec1.x * vec2.y) - (vec1.y * vec2.x)
        //print(result)
        return result
    }
    func getItem<T>(list : [T], index : Int)-> T{//works only for it's purpose
        if index >= list.count{
            return list[index % list.count]
        }
        else if index < 0{
            return list[index % list.count + list.count]
        }
        else {return list[index]}
    }

    func isPointInTriangle(pointInCheck : Point,
                           aPoint : Point,
                           bPoint : Point,
                           cPoint : Point
    )-> Bool{
        let ab = bPoint - aPoint
        let bc = cPoint - bPoint
        let ca = aPoint - cPoint

        let ap = pointInCheck - aPoint
        let bp = pointInCheck - bPoint
        let cp = pointInCheck - cPoint

        let cross1 = crossProduct(vec1: ab, vec2: ap)
        let cross2 = crossProduct(vec1: bc, vec2: bp)
        let cross3 = crossProduct(vec1: ca, vec2: cp)

        if (cross1 > 0 || cross2 > 0 || cross3 > 0){
            return false

        }
        return true
    }
    func nearestDistanceToLineBetweenTwoPoints(a :Point,
                                               b : Point,
                                               pointToCheck c : Point)-> Double{
        //formula
        let s1 = -(b.y) + a.y
        let s2 = b.x - a.x
        var mone = (c.x - a.x) * s1 + (c.y - a.y) * s2
        if mone < 0 {mone * (-1)}
        let mechane = sqrt(((s1*s1) + (s2*s2)))
        return mone / mechane

    }
    func areaOfTriangle(side1: Double, side2 : Double, side3: Double)->Double{
    //sqrt[s(s-a)(s-b)(s-c)], s is semiperimeter
    // s = (a + b + c)/2

    let s = (side1 + side2 + side3)/2
    let result = sqrt(s * (s - side1) * (s - side2) * (s - side3))
    return result
    }
    func distanceBetweenTwoPoints(pointOne: Point, pointTwo: Point)->Double{

        let ac = pointTwo.x - pointOne.x
        let bc = pointTwo.y - pointOne.y
        let ab = sqrt(ac*ac + bc*bc)
        return ab
    }
    func areaOfTriangleByPoints(first: Point, second: Point, third:Point)->Double{
        let ab = distanceBetweenTwoPoints(pointOne: first,
                                          pointTwo: second)
        let bc = distanceBetweenTwoPoints(pointOne: second,
                                          pointTwo: third)
        let ac = distanceBetweenTwoPoints(pointOne: first,
                                          pointTwo: third)
        return areaOfTriangle(side1: ab, side2: bc, side3: ac)
    }

    func isPointInTriangle2(pointInCheck p: Point, aPoint a: Point, bPoint b: Point, cPoint c:Point )->Bool{
        let mainArea = areaOfTriangleByPoints(
            first: a,
            second: b,
            third: c)

        let area1 = areaOfTriangleByPoints(
            first: a,
            second: b,
            third: p)

        let area2 = areaOfTriangleByPoints(
            first: b,
            second: p,
            third: c)

        let area3 = areaOfTriangleByPoints(
            first: a,
            second: p,
            third: c)
        var sum = mainArea - area1 - area2 - area3
        if sum < 0 {sum *= -1}
    //    print(mainArea)
    //    print(area1)
    //    print(area2)
    //    print(area3)
        print(sum)
        print(sum < 0.001)
        return sum < 0.001
    }
}
