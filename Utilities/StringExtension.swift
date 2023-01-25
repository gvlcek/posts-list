//
//  StringExtension.swift
//  Posts List
//
//  Created by Guadalupe Vlček on 23/01/2023.
//

import UIKit

extension String {
    func localized(bundle: Bundle = .main, tableName: String = "Localizable") -> String {
        return NSLocalizedString(self, tableName: tableName, value: "**\(self)**", comment: "")
    }
}
