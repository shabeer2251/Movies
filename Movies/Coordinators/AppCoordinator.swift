//
//  AppCoordinator.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import UIKit

enum AppTransition {
    case moviesScreen
    case moviesSearchItemList(item: MovieSearchTypeItem)
    case moviesList(item: MovieSearchTypeItem, title: String)
    case movieDetails(movie: Movie)
    case ratings(rating: Ratings)
}

class AppCoordinator {
    private let window: UIWindow
    private var rootViewController: UINavigationController
    
    // MARK: initialization
    init(window: UIWindow) {
        self.window = window
        rootViewController = UINavigationController()
    }
    
    // MARK: Coordinator methods
    func start() {
        window.rootViewController = rootViewController
        rootViewController.navigationBar.isHidden = true
    
        performTransition(transition: .moviesScreen)
        window.makeKeyAndVisible()
    }
    
    func performTransition(transition: AppTransition) {
        switch transition {
        case .moviesScreen:
            let viewModel = MoviesViewModel(delegate: self)
            let viewController = MoviesViewController(viewModel: viewModel)
            
            rootViewController.pushViewController(viewController, animated: true)
        
        case .moviesSearchItemList(let item):
            let viewModel = MoviesSeaarchItemListViewModel(delegate: self, movieSearchTypeItem: item)
            let viewController = MoviesSearchItemListViewController(viewModel: viewModel)
            rootViewController.pushViewController(viewController, animated: true)
        
        case .moviesList(let item, let title):
            let viewModel = MoviesListViewModel(delegate: self, title: title, movieSearchTypeItem: item)
            let viewController = MoviesListViewController(viewModel: viewModel)
            rootViewController.pushViewController(viewController, animated: true)
            
        case .movieDetails(let movie):
            let viewModel = MovieDetailsViewModel(delegate: self, movie: movie)
            let viewController = MovieDetailsViewController(viewModel: viewModel)
            rootViewController.pushViewController(viewController, animated: true)
            
        case .ratings(let rating):
            let viewModel = RatingViewModel(rating: rating)
            let viewController = RatingViewController(viewModel: viewModel)
            viewController.modalPresentationStyle = .overCurrentContext
            viewController.modalTransitionStyle = .crossDissolve
            rootViewController.present(viewController, animated: true, completion: nil)
            
        }
    }

}

// MARK: MoviesNavigationDelegate
extension AppCoordinator: MoviesNavigationDelegate {
    func handleMovieSearchTypeItemSelection(item: MovieRepresentable){
        if let item = item as? MovieSearchTypeItem {
            performTransition(transition: .moviesSearchItemList(item: item))
        } else if let item = item as? Movie {
            performTransition(transition: .movieDetails(movie: item))
        }
    }
}

// MARK: MoviesSearchItemListNavigationDelegate
extension AppCoordinator: MoviesSearchItemListNavigationDelegate {
    func handleMovieItemSelection(movieSearchTypeItem: MovieSearchTypeItem, searchItem: MovieRepresentable) {
        if let item = searchItem as? Movie {
            performTransition(transition: .movieDetails(movie: item))
        } else {
            performTransition(transition: .moviesList(item: movieSearchTypeItem, title: searchItem.description))
        }
    }
    
    func handleMoviesSeaarchItemListBack() {
        rootViewController.popViewController(animated: true)
    }
    
}

// MARK: MoviesListViewNavigationDelegate
extension AppCoordinator: MoviesListViewNavigationDelegate {
    func handleMoviesListSelection(movie: Movie) {
        performTransition(transition: .movieDetails(movie: movie))
    }
    
    func handleMoviesListBack() {
        rootViewController.popViewController(animated: true)
    }
}

// MARK: MovieDetailsNavigationDelegate
extension AppCoordinator: MovieDetailsNavigationDelegate {
    func handleRating(rating: Ratings) {
        performTransition(transition: .ratings(rating: rating))
    }
    
    func handleMovieDetailsViewModelBack() {
        rootViewController.popViewController(animated: true)
    }
}
