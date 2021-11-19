//
//  String + App.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import UIKit

extension String {
    var inDouble: Double {
        if self.contains("%") {
            let left = Double(String(self.dropLast())) ?? 0.0
            return left/100
        } else {
            let operands = self.components(separatedBy: "/")
            let left = Double(operands.first ?? "") ?? 0.0
            let right = Double(operands.last ?? "") ?? 0.0
            return left/right
        }
    }
    
    var inPercentage: String {
        if self.contains("%") {
            return self
        } else {
            return "\(Int((self.inDouble * 100).rounded()))%"
        }
    }
}
