//
//  UIFont+App.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import UIKit

extension UIFont {
    static func regularAppFont(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size , weight: .regular)
    }
    
    static func mediumAppFont(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }
    
    static func boldAppFont(of size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .bold)
    }
}


