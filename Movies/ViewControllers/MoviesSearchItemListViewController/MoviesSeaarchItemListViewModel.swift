//
//  MoviesSeaarchItemListViewModel.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import Foundation

protocol MoviesSearchItemListNavigationDelegate: AnyObject {
    func handleMovieItemSelection(movieSearchTypeItem: MovieSearchTypeItem, searchItem: MovieRepresentable)
    func handleMoviesSeaarchItemListBack()
}

class MoviesSeaarchItemListViewModel {
    var dataSource = [MovieRepresentable]()
    var movieSearchTypeItem: MovieSearchTypeItem
    var reloadTableView: (() -> Void)?
    weak var navigationDelegate: MoviesSearchItemListNavigationDelegate?
    
    init(delegate: MoviesSearchItemListNavigationDelegate, movieSearchTypeItem: MovieSearchTypeItem) {
        self.navigationDelegate = delegate
        self.movieSearchTypeItem = movieSearchTypeItem
        self.setupDataSource()
    }
    
    func setupDataSource() {
        switch movieSearchTypeItem {
        case .allMovies:
            DataLoader.shared.allMovies(completion: { response in
                switch response {
                case .success(let list):
                    self.dataSource = list
                    reloadTableView?()
                case .failure(let error):
                    print("Failed to fetch movies \(error)")
                }
            })
            reloadTableView?()
        default:
            DataLoader.shared.movies(groupedBy: movieSearchTypeItem) {[weak self] response in
                switch response {
                case .success(let list):
                    self?.dataSource = list.map({ $0.description })
                    reloadTableView?()
                case .failure(let error):
                    print("Failed to fetch movies based on \(movieSearchTypeItem.rawValue): \(error)")
                }
            }
        }
    }
    
    func setupDataSourceBasedOnSearchText(searchText: String) {
        if searchText.isEmpty {
            setupDataSource()
        } else {
            switch movieSearchTypeItem {
            case .allMovies:
                DataLoader.shared.getMoviesBasedOnSearchText(searchText: searchText) { response in
                    switch response {
                    case .success(let movies):
                        self.dataSource.removeAll()
                        self.dataSource = movies
                        self.reloadTableView?()
                    case .failure(let error):
                        print("failed to load movies \(error)")
                    }
                }
            default:
                DataLoader.shared.movies(groupedBy: movieSearchTypeItem) {[weak self] response in
                    switch response {
                    case .success(let list):
                        self?.dataSource = list.map({ $0.description }).filter({ $0.description.lowercased().contains(searchText.lowercased())})
                        reloadTableView?()
                    case .failure(let error):
                        print("Failed to fetch movies based on \(movieSearchTypeItem.rawValue): \(error)")
                    }
                }
            }
        }
       
       
    }
    
    func handleBack() {
        self.navigationDelegate?.handleMoviesSeaarchItemListBack()
    }
    
    func handleSelection(searchItem: MovieRepresentable) {
        self.navigationDelegate?.handleMovieItemSelection(movieSearchTypeItem: self.movieSearchTypeItem, searchItem: searchItem)
    }
    
}
