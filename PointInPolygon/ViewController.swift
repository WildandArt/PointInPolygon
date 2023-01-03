//
//  ViewController.swift
//  PointInPolygon
//
//  Created by Artemy Ozerski on 29/12/2022.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {
    var parsedData = ""
    var elementName = ""
    var vertices : [Point] = []

    var importButton : UIButton = {
        let button = UIButton(frame: .zero)
        button.backgroundColor = .systemGreen
        button.setTitle("Import", for: .normal)
        button.titleLabel?.font =  UIFont.systemFont(ofSize: 18, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(pickKml), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        configureViews()
    }
    func configureViews(){
        view.addSubview(importButton)
        NSLayoutConstraint.activate([
            importButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20),
            importButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            importButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            importButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: Parser

extension ViewController{

    func parsePlease(with url : URL?){
        guard let url = url else {return}
        let parser = XMLParser(contentsOf: url)
        parser?.delegate = self
        parser?.parse()
    }
    func fromStringIntoCoordinatesArray(){

        if !parsedData.isEmpty{
            var newString = parsedData.components(separatedBy: ",0")
            newString.removeAll{$0.isEmpty}
            newString.forEach { str1 in
                var separated = str1.components(separatedBy: ",")
                var newSeparated = separated[0].trimmingCharacters(in: CharacterSet(charactersIn: " "))
                let x = Double(newSeparated) ?? 0
                let y = Double(separated[1]) ?? 0
                var p = Point(x: x, y: y)
                vertices.append(p)
            }
            print(vertices.count)
//            print(vertices[0])
//            print(newString[0])
        }
    }
}

extension ViewController : XMLParserDelegate{
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if !data.isEmpty{
            if elementName == "coordinates"{
                self.parsedData = data
                fromStringIntoCoordinatesArray()

            }
        }
        //print(data)
    }
    func parser(_ parser: XMLParser,
                didEndElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?) {
        if elementName == "coordinates"{
            self.elementName = ""
            print("end")
        }
    }

    func parser(_ parser: XMLParser,
                didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String] = [:]) {

        if elementName == "coordinates"{
            self.elementName = elementName
            print("start")
        }

    }
}


extension ViewController : UIDocumentPickerDelegate {
    @objc
    func pickKml(sender: UIBarButtonItem) {
        let pickerViewController = UIDocumentPickerViewController(
            documentTypes: [kUTTypeXML as String], in: .import)

        pickerViewController.delegate = self
        present(pickerViewController, animated: true)
    }

    // MARK: UIDocumentPickerDelegate

    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        assert(urls.count == 1)
        parsePlease(with: urls[0])
        let vc = XYPickerViewController()
        //fromStringIntoCoordinatesArray()
        vc.vertices = vertices
        navigationController?.pushViewController(vc, animated: true)
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("cancelled")
        controller.dismiss(animated: true)
    }
}
