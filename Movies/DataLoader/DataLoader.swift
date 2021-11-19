//
//  DataLoader.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import Foundation

class DataLoader {
    
    static let shared = DataLoader()
    private init() { }
    
    func allMovies(completion: (Result<[Movie], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "movies", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let movies = try JSONDecoder().decode([Movie].self, from: data)
            completion(.success(movies))
        } catch {
            completion(.failure(error))
        }
    }
    
    func movies(groupedBy: MovieSearchTypeItem, completion: (Result<[String], Error>) -> Void) {
        self.allMovies {[weak self] response in
            switch response {
            case .success(let movies):
                var result = [String]()
                for eachItem in movies {
                    var items = [String]()
                    switch groupedBy {
                    case .year:
                        items = eachItem.year?.components(separatedBy: "–") ?? []
                    case .genre:
                        items = eachItem.genre?.components(separatedBy: ", ") ?? []
                    case .actors:
                        items = eachItem.actors?.components(separatedBy: ", ") ?? []
                    case .directors:
                        //TODO: handle N/A
                        items = eachItem.director?.components(separatedBy: ", ") ?? []
                    }
                    items.forEach { item in
                        if !result.contains(item), !item.isEmpty, item != "N/A" {
                            result.append(item)
                        }
                    }
                }
                completion(.success(result.sorted()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
        
    func getMovies(basedOn movieSearchTypeItem: MovieSearchTypeItem, searchBy: String,  completion: (Result<[Movie], Error>) -> Void) {
        self.allMovies { response in
            switch response {
            case .success(let movies):
                var result = [Movie]()
                    switch movieSearchTypeItem {
                    case .year:
                        result = movies.filter( {($0.year ?? "").contains(searchBy)})
                    case .genre:
                        result = movies.filter( {($0.genre ?? "").contains(searchBy)})
                    case .actors:
                        result = movies.filter( {($0.actors ?? "").contains(searchBy)})
                    case .directors:
                        result = movies.filter( {($0.director ?? "").contains(searchBy)})
                    }
                //TO DO: sort
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMoviesBasedOnSearchText(searchText: String,  completion: (Result<[Movie], Error>) -> Void) {
        self.allMovies { response in
            switch response {
            case .success(let movies):
                let result = movies.filter({ $0.willSatisfySearchText(searchText: searchText.lowercased())})
                //TO DO: sort
                completion(.success(result))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
