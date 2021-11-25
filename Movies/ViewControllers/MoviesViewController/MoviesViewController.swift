//
//  MoviesViewController.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import UIKit

class MoviesViewController: UIViewController {
    private let viewModel: MoviesViewModel
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: initialization
    init(viewModel: MoviesViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Viewcontroller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }
    
    func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupUI() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MoviesListTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesListTableViewCell")
        tableView.register(UINib(nibName: "SearchTypeItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTypeItemTableViewCell")
        StyleKit.applyBoldLabelStyle(label: titleLabel)
        titleLabel.text = "Movies"
        searchBar.placeholder = "Search Movies by title/actor/genre/director"

    }
}

// MARK: UITableViewDataSource, UITableViewDelegate
extension MoviesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.dataSource.first is MovieSearchTypeItem {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTypeItemTableViewCell", for: indexPath) as? SearchTypeItemTableViewCell, let item = self.viewModel.dataSource[indexPath.row] as? MovieSearchTypeItem  else { return UITableViewCell() }
            cell.setupCell(title: item.rawValue)
            return cell
        } else if viewModel.dataSource.first is Movie  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath) as? MoviesListTableViewCell,let movie = self.viewModel.dataSource[indexPath.row] as? Movie else { return UITableViewCell() }
            cell.setupCell(movie: movie)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let item = self.viewModel.dataSource[indexPath.row]
        self.viewModel.handleSelection(item: item)
    }
    
}

// MARK: UISearchBarDelegate
extension MoviesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.setupDataSourceBasedOnSearchText(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
