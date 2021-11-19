//
//  MoviesViewModel.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import Foundation

protocol MovieRepresentable {
    
}


protocol MoviesNavigationDelegate: AnyObject {
    func handleMovieSearchTypeItemSelection(item: MovieRepresentable)
}

class MoviesViewModel {
    var dataSource = [MovieRepresentable]()
    var reloadTableView: (() -> Void)?
    weak var navigationDelegate: MoviesNavigationDelegate?
    init(delegate: MoviesNavigationDelegate) {
        self.navigationDelegate = delegate
        self.setupInitialDataSource()
    }
    
    func setupInitialDataSource() {
        self.dataSource = MovieSearchTypeItem.allCases
        reloadTableView?()
    }
    
    func setupDataSourceBasedOnSearchText(searchText: String) {
        if searchText.isEmpty {
            setupInitialDataSource()
        } else {
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
        }
    }
    
    
    func handleSelection(item: MovieRepresentable) {
        self.navigationDelegate?.handleMovieSearchTypeItemSelection(item: item)
    }
    
}



