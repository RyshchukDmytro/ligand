//
//  API.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import Foundation

struct Model {
    let atoms: Atom
    let conection: [Int]
}

struct Atom {
    let first: Double
    let second: Double
    let third: Double
    let name: String
}

class Api {
    var elementsDescription = [String]()
    var atoms = [Atom]()
    var conect = [[Int]]()
    var model = [Model]()
    
    func getProteinFullDescription(name link: String) {
        DispatchQueue.global().async {
            if let url = URL(string: "https://file.rcsb.org/ligands/view/\(link)_model.pdb") {
                do {
                    let content = try String(contentsOf: url)
                    for line in content.split(separator: "\n") {
                        self.elementsDescription.append(String(line))
                    }
                    self.parse(data: self.elementsDescription)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    private func parse(data: [String]) {
        var linesCount = 0
        for line in data {
            var atom = Atom(first: 0.0, second: 0.0, third: 0.0, name: "")
            var conectArray = [Int]()
            if line.hasPrefix("ATOM") {
                linesCount += 1
                let newLine = line.substring(from: 32)
                let first = newLine.substring(with: 0..<6).trimmingCharacters(in: .whitespaces)
                let second = newLine.substring(with: 7..<14).trimmingCharacters(in: .whitespaces)
                let third = newLine.substring(with: 15..<22).trimmingCharacters(in: .whitespaces)
                let element = String(newLine.last ?? " ")
                
                if let f = Double(first), let s = Double(second), let t = Double(third) {
                    atom = Atom(first: f, second: s, third: t, name: element)
                    atoms.append(atom)
                }
            } else if line.hasPrefix("CONECT") {
                var conectNumber = ""
                var isNumber = false
                var count = 0
                
                line.forEach { (c) in
                    count += 1
                    if c.isNumber {
                        conectNumber += String(c)
                        isNumber = true
                        if line.count == count {
                            conectArray.append(Int(conectNumber)!)
                        }
                    }  else if !c.isNumber && isNumber {
                        conectArray.append(Int(conectNumber)!)
                        conectNumber = ""
                        isNumber = false
                    }
                }
                conect.append(conectArray)
            }
        }
        for time in 0..<linesCount {
            model.append(Model(atoms: atoms[time], conection: conect[time]))
        }
        print(model)
    }
}


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
