//
//  Double.swift
//  CountOnMe
//
//  Created by Maxime Girard on 26/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

// Extension used when computing to remove any 0 after the decimal
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
