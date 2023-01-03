//
//  XYPickerViewController.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 02/01/2023.
//

import UIKit

class XYPickerViewController: UIViewController {
    var x : String = ""
    var y : String = ""
    var vertices : [Point] = []


    var fieldX : UITextField = {
        let fieldX = UITextField()
        fieldX.tag = 0
        fieldX.placeholder = "enter x"
        fieldX.textColor = .white
        fieldX.borderStyle = .line
        fieldX.layer.borderColor = UIColor.gray.cgColor
        fieldX.layer.borderWidth = 1
        fieldX.keyboardType = .numbersAndPunctuation
        fieldX.translatesAutoresizingMaskIntoConstraints = false
        return fieldX
    }()
    @objc func fieldXAction(){
        x = fieldX.text ?? ""
        print("x: \(x)")
    }
    @objc func fieldYAction(){
        y = fieldY.text ?? ""
        print("y: \(y)")
    }
    var fieldY : UITextField = {
        let fieldY = UITextField()
        fieldY.tag = 1
        fieldY.placeholder = "enter y"
        fieldY.borderStyle = .line
        fieldY.layer.borderColor = UIColor.gray.cgColor
        fieldY.textColor = .white
        fieldY.layer.borderWidth = 1
        fieldY.translatesAutoresizingMaskIntoConstraints = false
        fieldY.keyboardType = .numbersAndPunctuation
        return fieldY
    }()
    var nextButton : UIButton = {
        let nextButton = UIButton()
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.backgroundColor = .systemGreen
        nextButton.setTitle("Next", for: .normal)
        nextButton.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        nextButton.layer.cornerRadius = 10
        nextButton.layer.backgroundColor = UIColor.systemGreen.cgColor

        return nextButton
    }()


@objc
    func didTap(){
        //calculate
        let solver = PointInPolygonSolver()
        let vc = ShowResultsViewController()

        let p = Point(x: Double(x) ?? 0, y: Double(y) ?? 0)
        print(p)
        vc.pointInCheck = p
        if vertices.isEmpty{print("vertices empty")}
        vc.vertices = vertices

        navigationController?.pushViewController(vc, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        nextButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        fieldX.addTarget(self, action: #selector(fieldXAction), for: .editingChanged)
        fieldY.addTarget(self, action: #selector(fieldYAction), for: .editingChanged)

        fieldX.delegate = self
        fieldY.delegate = self
        configureViews()
    }
    func configureViews(){
        view.addSubview(fieldX)
        view.addSubview(fieldY)
        view.addSubview(nextButton)

        NSLayoutConstraint.activate([
            fieldX.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fieldX.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            fieldX.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -200),

            fieldY.centerXAnchor.constraint(equalTo: fieldX.centerXAnchor),
            fieldY.widthAnchor.constraint(equalTo: fieldX.widthAnchor),
            fieldY.topAnchor.constraint(equalTo: fieldX.bottomAnchor, constant: 20),

            nextButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            nextButton.heightAnchor.constraint(equalToConstant: 40),
            nextButton.topAnchor.constraint(equalTo: fieldY.bottomAnchor, constant: 20),
            nextButton.centerXAnchor.constraint(equalTo: fieldY.centerXAnchor)
        ])
    }
}
extension XYPickerViewController : UITextFieldDelegate{
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            textField.text = ""
        }
        else if textField.tag == 1{
            textField.text = ""
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin \(textField.tag)")

    }
    func textFieldDidEndEditing(_ textField: UITextField,
                                reason: UITextField.DidEndEditingReason) {
        print("end \(textField.tag)")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
