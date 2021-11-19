//
//  MoviesListViewModel.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import Foundation

protocol MoviesListViewNavigationDelegate: AnyObject {
    func handleMoviesListBack()
    func handleMoviesListSelection(movie: Movie)
}

class MoviesListViewModel {
    var dataSource = [Movie]()
    var title: String
    var movieSearchTypeItem: MovieSearchTypeItem
    var reloadTableView: (() -> Void)?
    weak var navigationDelegate: MoviesListViewNavigationDelegate?
    
    init(delegate: MoviesListViewNavigationDelegate, title: String, movieSearchTypeItem: MovieSearchTypeItem) {
        self.navigationDelegate = delegate
        self.title = title
        self.movieSearchTypeItem = movieSearchTypeItem
        self.setupDataSource()
    }
    
    func setupDataSource() {
        DataLoader.shared.getMovies(basedOn: movieSearchTypeItem, searchBy: title) { response in
            switch response {
            case .success(let list):
                self.dataSource = list
                reloadTableView?()
            case .failure(let error):
                print("Failed to fetch movies based on \(movieSearchTypeItem.rawValue): \(error)")
            }
        }
    }
    
    func handleBack() {
        self.navigationDelegate?.handleMoviesListBack()
    }
    
    func handleSelection(movie: Movie) {
        self.navigationDelegate?.handleMoviesListSelection(movie: movie)
    }
    
}
