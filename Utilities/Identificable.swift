//
//  Identificable.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import UIKit

protocol Identificable {
    static var identifier: String { get }
}

extension Identificable {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController: Identificable {}

extension UIView: Identificable {}
