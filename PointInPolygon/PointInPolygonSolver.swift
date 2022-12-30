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



    func triangulate(vertices : [Point])->Bool{

        var triangles : [Int] = []
        var errorMsg : String = ""
        var indexList = Array(0...vertices.count - 1)

        if !isValidPolygon(vertices) {return false}

        while indexList.count > 3{//if less than 3 we add the last to list of triangles

            for i in 0..<indexList.count{

                var isEar = true

                var a = indexList[i]
                var b = getItem(list: indexList, index: i - 1)
                var c = getItem(list: indexList, index: i + 1)

                var va = vertices[a]
                var vb = vertices[b]
                var vc = vertices[c]

                if angleIsMoreThan180(va: va, vb: vb, vc: vc){
                    continue
                }

                //check if a vertice is inside a triangle
                for j in 0..<vertices.count{
                    if j == a || j == b || j == c{
                        continue
                    }
                    var p = vertices[j]
                    if isPointInTriangle(pointInCheck: p, aPoint: va, bPoint: vb, cPoint: vc) {
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
        return true
    }
}
extension PointInPolygonSolver{
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
        var va_to_vb = vb - va
        var va_to_vc = vc - va
//        print("va_to_vb :\(va_to_vb)")
//        print("va_to_vc :\(va_to_vc)")

        return crossProduct(vec1: va_to_vb,
                            vec2: va_to_vc) < 0
    }
    func crossProduct(vec1 : Point, vec2 : Point)-> Double{
        let result = (vec1.x * vec2.y) - (vec1.y * vec2.x)
        print(result)
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
        var ab = bPoint - aPoint
        var bc = cPoint - bPoint
        var ca = aPoint - cPoint

        var ap = pointInCheck - aPoint
        var bp = pointInCheck - bPoint
        var cp = pointInCheck - cPoint

        var cross1 = crossProduct(vec1: ab, vec2: ap)
        var cross2 = crossProduct(vec1: bc, vec2: bp)
        var cross3 = crossProduct(vec1: ca, vec2: cp)

        if (cross1 > 0 || cross2 > 0 || cross3 > 0){return false}
        return true
    }
}
