//
//  API.swift
//  SwiftProtein
//
//  Created by Dmytro Ryshchuk on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import Foundation

class Api {
    class func getProteinFullDescription(name link: String, comletionHandler: @escaping (String?) -> Void) {
        DispatchQueue.global().async {
            guard let url = URL(string: "https://file.rcsb.org/ligands/view/\(link)_model.pdb") else { comletionHandler(nil)
                return
            }
            do {
                let content = try String(contentsOf: url)
                comletionHandler(content)
            } catch {
                print(error)
                comletionHandler(nil)
            }
        }
    }
}
