//
//  Movie.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import Foundation

struct Ratings: Codable {
    var source: String?
    var value: String?

    enum CodingKeys: String, CodingKey {
        case source = "Source"
        case value = "Value"
    }
}

struct Movie: Codable, MovieRepresentable {
    var title: String?
    var year: String?
    var released: String?
    var genre: String?
    var director: String?
    var actors: String?
    var plot: String?
    var language: String?
    var poster: String?
    var ratings: [Ratings]?
    
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case released = "Released"
        case genre = "Genre"
        case director = "Director"
        case actors = "Actors"
        case plot = "Plot"
        case language = "Language"
        case poster = "Poster"
        case ratings = "Ratings"
    }
    
    func willSatisfySearchText(searchText: String) -> Bool {
        if let title = self.title?.lowercased(), title.contains(searchText) {
            return true
        } else if let actors = self.actors?.lowercased(), actors.contains(searchText) {
            return true
        } else if let director = self.director?.lowercased(), director.contains(searchText) {
            return true
        } else if let genre = self.genre?.lowercased(), genre.contains(searchText) {
            return true
        }
        return false
    }
}
