//
//  MoviesSeaarchItemListViewModel.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import Foundation

protocol MoviesSearchItemListNavigationDelegate: AnyObject {
    func handleMovieItemSelection(movieSearchTypeItem: MovieSearchTypeItem, searchItem: String)
    func handleMoviesSeaarchItemListBack()
}

class MoviesSeaarchItemListViewModel {
    var dataSource = [String]()
    var movieSearchTypeItem: MovieSearchTypeItem
    var reloadTableView: (() -> Void)?
    weak var navigationDelegate: MoviesSearchItemListNavigationDelegate?
    
    init(delegate: MoviesSearchItemListNavigationDelegate, movieSearchTypeItem: MovieSearchTypeItem) {
        self.navigationDelegate = delegate
        self.movieSearchTypeItem = movieSearchTypeItem
        self.setupDataSource()
    }
    
    func setupDataSource() {
        DataLoader.shared.movies(groupedBy: movieSearchTypeItem) {[weak self] response in
            switch response {
            case .success(let list):
                self?.dataSource = list
                reloadTableView?()
            case .failure(let error):
                print("Failed to fetch movies based on \(movieSearchTypeItem.rawValue): \(error)")
            }
        }
    }
    
    func handleBack() {
        self.navigationDelegate?.handleMoviesSeaarchItemListBack()
    }
    
    func handleSelection(searchItem: String) {
        self.navigationDelegate?.handleMovieItemSelection(movieSearchTypeItem: self.movieSearchTypeItem, searchItem: searchItem)
    }
    
}
