//
//  Extensions.swift
//  SwiftProtein
//
//  Created by Nazar Prysiazhnyi on 10/12/19.
//  Copyright © 2019 Dmytro Ryshchuk. All rights reserved.
//

import Foundation
import UIKit

enum Elements: String {
    case Carbon = "C"
    case Oxygen = "O"
    case Hydrogen = "H"
    case Nitrogen = "N"
    case Sulphur = "S"
    case Boron = "B", Chlorine = "Cl"
    case Phosphorus = "P", Iron = "Fe", Barium = "Ba"
    case Sodium = "Na"
    case Magnesium = "Ma"
    case Zn, Cu, Ni, Br
    case Ca, Mn, Al, Ti, Cr, Ag
    case Iodine = "I"
    case Lithium = "Li"
    case Helium = "He"
    case Unknown
    
    func introduce() -> UIColor {
        switch self {
        case .Carbon: return UIColor(red: 200.0 / 255.0, green: 200.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0) // light grey
        case .Oxygen: return UIColor(red: 240.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0) // red
        case .Hydrogen: return UIColor(red: 255.0 / 255.0, green: 255.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0) // white
        case .Nitrogen: return UIColor(red: 143.0 / 255.0, green: 143.0 / 255.0, blue: 255.0 / 255.0, alpha: 1.0) // light blue
        case .Sulphur: return UIColor(red: 255.0 / 255.0, green: 200.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0) // sulphur yellow
        case .Boron, .Chlorine: return .green // green 
        case .Phosphorus, .Iron, .Barium: return UIColor(red: 255.0 / 255.0, green: 165.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0) // orange
        case .Sodium: return .blue // blue
        case .Magnesium: return UIColor(red: 34.0 / 255.0, green: 139.0 / 255.0, blue: 34.0 / 255.0, alpha: 1.0) // forest green
        case .Zn, .Cu, .Ni, .Br: return UIColor(red: 165.0 / 255.0, green: 42.0 / 255.0, blue: 42.0 / 255.0, alpha: 1.0) // brown
        case .Ca, .Mn, .Al, .Ti, .Cr, .Ag: return UIColor(red: 128.0 / 255.0, green: 128.0 / 255.0, blue: 144.0 / 255.0, alpha: 1.0) // dark grey
        case .Iodine: return UIColor(red: 218.0 / 255.0, green: 165.0 / 255.0, blue: 32.0 / 255.0, alpha: 1.0) // goldenrod
        case .Lithium: return UIColor(red: 160.0 / 255.0, green: 32.0 / 255.0, blue: 240.0 / 255.0, alpha: 1.0) // purple
        case .Helium: return UIColor(red: 255.0 / 255.0, green: 192.0 / 255.0, blue: 203.0 / 255.0, alpha: 1.0) // pink
        case .Unknown: return UIColor(red: 255.0 / 255.0, green: 20.0 / 255.0, blue: 147.0 / 255.0, alpha: 1.0) // deep pink
        }
    }
}

/*
 
 ELEMENT                   COLOR NAME       RGB DECIMAL    RGB HEXADECIMAL
 Carbon                    light grey       [200,200,200]  C8 C8 C8
 Oxygen                    red              [240,0,0]      F0 00 00
 Hydrogen                  white            [255,255,255]  FF FF FF
 
 Nitrogen                  light blue       [143,143,255]  8F 8F FF
 Sulphur                   sulphur yellow   [255,200,50]   FF C8 32
 Chlorine, Boron           green            [0,255,0]      00 FF 00
 
 Phosphorus, Iron, Barium  orange           [255,165,0]    FF A5 00
 Sodium                    blue             [0,0,255]      00 00 FF
 Magnesium                 forest green     [34,139,34]    22 8B 22
 Zn, Cu, Ni, Br            brown            [165,42,42]    A5 2A 2A
 
 Ca, Mn, Al, Ti, Cr, Ag    dark grey        [128,128,144]  80 80 90
 F, Si, Au                 goldenrod        [218,165,32]   DA A5 20
 Iodine                    purple           [160,32.240]   A0 20 F0
 
 Lithium                   firebrick        [178,34,34]    B2 22 22
 Helium                    pink             [255,192,203]  FF C0 CB
 Unknown                   deep pink        [255,20,147]   FF 14 93
 */

