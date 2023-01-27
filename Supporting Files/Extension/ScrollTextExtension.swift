//
//  ScrollTextExtension.swift
//  CountOnMe
//
//  Created by Maxime Girard on 26/01/2023.
//  Copyright © 2023 Vincent Saluzzo. All rights reserved.
//

import Foundation

import UIKit

extension UITextView {

    func scrollToBotom() {
        let range = NSRange(location: text.count - 1, length: 1)
        scrollRangeToVisible(range)
    }

}
