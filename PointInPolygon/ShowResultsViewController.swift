//
//  ShowResultsViewController.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 02/01/2023.
//

import UIKit

class ShowResultsViewController: UIViewController {
    let child = SpinnerViewController()
    var vertices : [Point]?
    var pointInCheck : Point?

    var labelYesOrNO : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var labelDistance : UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        configureViews()

        let solver = PointInPolygonSolver()

        guard let vertices = vertices else {return}
        guard let pointInCheck = pointInCheck else {return}
        let isOutsideOfTheBox = solver.checkIfOutSideABoxOfPolygon(vertices: vertices, pointToCheck: pointInCheck)
        if isOutsideOfTheBox{
            let dist = solver.findADistanceBetweenAPolygonAndPoint(vertices: vertices,
                                                                   pointToCheck: pointInCheck)
            print("isOutside")
            print("Out")
            print(dist)
            self.labelYesOrNO.textColor = .systemRed
            self.labelYesOrNO.text = "Outside of a Polygon"
            self.labelDistance.text = String(dist)
            self.labelDistance.alpha = 1
        }
        else{
            //check if in a polygon
            if solver.isPointInPolygon(vertices: vertices, pointToCheck: pointInCheck){
                DispatchQueue.main.async {
                                    self.labelYesOrNO.textColor = .systemGreen
                                    self.labelYesOrNO.text = "Inside a Polygon"
                                }
            }
            else{
                let dist = solver.findADistanceBetweenAPolygonAndPoint(vertices: vertices,
                                                                       pointToCheck: pointInCheck)
                DispatchQueue.main.async {
                                      self.labelYesOrNO.textColor = .systemRed
                                      self.labelYesOrNO.text = "Outside of a Polygon"
                                      self.labelDistance.text = String(dist)
                                      self.labelDistance.alpha = 1
                              }
            }
        }


        //        if isPointInPolygon(vertices: vertices,
        //                            pointToCheck: pointToCheck){
        //            return Answer(isIn: true)
        //
        //        }
        //    else{
        //        let res = findADistanceBetweenAPolygonAndPoint(vertices: vertices,
        //                                             pointToCheck: pointToCheck)
        //        return Answer(isIn: false, distance: res)
        //    }

        //print("ans.isIn:\(ans.isIn)")
        //        solver.getAnswers(vertices: vertices,
        //                           pointToCheck: pointInCheck) { [weak self] answer in
        //            guard let self = self else{return}
        //            //self.createSpinnerView()
        //            print("Thread\(Thread.isMainThread)")
        //            if answer.isIn{
        //                DispatchQueue.main.async {
        //                    self.labelYesOrNO.textColor = .systemGreen
        //                    self.labelYesOrNO.text = "Inside a Polygon"
        //                }
        //            }
        //            else{
        //                DispatchQueue.main.async {
        //                    if let distance = answer.distance{
        //                        self.labelYesOrNO.textColor = .systemRed
        //                        self.labelYesOrNO.text = "Outside of a Polygon"
        //                        self.labelDistance.text = String(distance)
        //                        //self.labelDistance.alpha = 1
        //                    }
        //                }
        //            }
        //            //self.stopSpinner()
        //
        //        }
        //}
    }
}

extension ShowResultsViewController{
    func configureViews(){
        view.addSubview(labelYesOrNO)
        view.addSubview(labelDistance)
        NSLayoutConstraint.activate([
            labelYesOrNO.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelYesOrNO.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            labelYesOrNO.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            labelYesOrNO.heightAnchor.constraint(equalToConstant: 50),

            labelDistance.topAnchor.constraint(equalTo: labelYesOrNO.bottomAnchor, constant: 30),
            labelDistance.widthAnchor.constraint(equalTo: labelYesOrNO.widthAnchor),
            labelDistance.heightAnchor.constraint(equalToConstant: 50),
            labelDistance.centerXAnchor.constraint(equalTo: labelYesOrNO.centerXAnchor)


        ])
    }
    func createSpinnerView() {

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    func stopSpinner(){
        DispatchQueue.main.async {[weak self] in
            guard let self = self else {return}
        // then remove the spinner view controller
            self.child.willMove(toParent: nil)
            self.child.view.removeFromSuperview()
            self.child.removeFromParent()
        //self.view.layoutSubviews()
                }
    }
}
