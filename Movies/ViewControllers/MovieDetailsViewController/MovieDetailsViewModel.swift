//
//  MovieDetailsViewModel.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import Foundation

protocol MovieDetailsNavigationDelegate: AnyObject {
    func handleMovieDetailsViewModelBack()
    func handleRating(rating: Ratings)
}

class MovieDetailsViewModel {
    var movie: Movie
    weak var navigationDelegate: MovieDetailsNavigationDelegate?
    
    init(delegate: MovieDetailsNavigationDelegate, movie: Movie) {
        self.navigationDelegate = delegate
        self.movie = movie
    }
    
    func handleBack() {
        self.navigationDelegate?.handleMovieDetailsViewModelBack()
    }
    
    func availableRatingType(type: RatingsType) -> Bool {
        guard let ratings = self.movie.ratings else { return false }
        return ratings.contains(where: { $0.source == type.rawValue })
    }
    
    
    func getTitleWithReleaseDateText() -> String {
        return (self.movie.title ?? "") + ":  (" + (self.movie.released ?? "") + ")"
    }
    
    func getCastAndCrew() -> String {
        //TODO: handle N/A
        return "Cast & Crew: " + (self.movie.actors ?? "") + ", " + (self.movie.director ?? "")
    }
    
    func handleRatingSelection(ratingsType: RatingsType) {
        guard let rating = self.movie.ratings?.filter( { $0.source == ratingsType.rawValue}).first else { return }
        self.navigationDelegate?.handleRating(rating: rating)
    }
    
}
