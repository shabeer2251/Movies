//
//  Constant.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import Foundation

var cache = NSCache<AnyObject, AnyObject>()

enum RatingsType: String {
    case imdb = "Internet Movie Database"
    case rottenTomatoes = "Rotten Tomatoes"
    case metaCritic = "Metacritic"
}

enum MovieSearchTypeItem: String, MovieRepresentable, CaseIterable {
    case year = "Year"
    case genre = "Genre"
    case directors = "Directors"
    case actors = "Actors"
    case allMovies = "All Movies"
    
    var description: String {
        return self.rawValue
    }
}
