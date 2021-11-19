//
//  RatingViewModel.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import Foundation

class RatingViewModel {
    var rating: Ratings
    
    init(rating: Ratings) {
        self.rating = rating
    }
    
    func getRatingInPercentage() -> String {
        guard let value = rating.value else { return "0.0%" }
        return value.inPercentage
    }
    
    func getRatingInDouble() -> Double {
        guard let value = rating.value else { return 0.0 }
        return value.inDouble
    }
}
