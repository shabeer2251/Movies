//
//  UIImageView + App.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import UIKit

extension UIImageView {
    
    func downloadContentFromUrl(url: String) {
        DispatchQueue.global().async {
            guard let url = URL(string: url) else { return }
            if let data = cache.object(forKey: NSString(string: url.absoluteString)) as? NSData {
                DispatchQueue.main.async {
                self.image = UIImage(data: data as Data)
                return
                }
            }
            let data = try? Data(contentsOf: url)
            if let theData = data {
                DispatchQueue.main.async {
                    cache.setObject(NSData(data: theData) , forKey: NSString(string: url.absoluteString))
                    self.image = UIImage(data: theData)
                }
            }
        }
    }
}
