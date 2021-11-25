//
//  MoviesSearchItemListViewController.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import UIKit

class MoviesSearchItemListViewController: UIViewController {
    private let viewModel: MoviesSeaarchItemListViewModel
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    // MARK: initialization
    init(viewModel: MoviesSeaarchItemListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.viewModel.handleBack()
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
        searchBar.placeholder = "Search by \(viewModel.movieSearchTypeItem.rawValue)"
        StyleKit.applyBoldLabelStyle(label: titleLabel)
        titleLabel.text = viewModel.movieSearchTypeItem.rawValue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        tableView.register(UINib(nibName: "SearchTypeItemTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchTypeItemTableViewCell")
        tableView.register(UINib(nibName: "MoviesListTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesListTableViewCell")
    }

}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MoviesSearchItemListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.dataSource.first is Movie  {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath) as? MoviesListTableViewCell,let movie = self.viewModel.dataSource[indexPath.row] as? Movie else { return UITableViewCell() }
            cell.setupCell(movie: movie)
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTypeItemTableViewCell", for: indexPath) as? SearchTypeItemTableViewCell  else { return UITableViewCell() }
            let item = self.viewModel.dataSource[indexPath.row].description
            cell.setupCell(title: item)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        self.viewModel.handleSelection(searchItem: self.viewModel.dataSource[indexPath.row])
    }
    
}

// MARK: UISearchBarDelegate
extension MoviesSearchItemListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.setupDataSourceBasedOnSearchText(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
