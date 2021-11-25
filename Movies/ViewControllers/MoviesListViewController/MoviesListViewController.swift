//
//  MoviesListViewController.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import UIKit

class MoviesListViewController: UIViewController {
    private let viewModel: MoviesListViewModel

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: initialization
    init(viewModel: MoviesListViewModel) {
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

    @IBAction func backButtonAction(_ sender: Any) {
        self.viewModel.handleBack()
    }
    
    func bindViewModel() {
        viewModel.reloadTableView = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func setupUI() {
        StyleKit.applyBoldLabelStyle(label: titleLabel)
        titleLabel.text = viewModel.title
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: "MoviesListTableViewCell", bundle: nil), forCellReuseIdentifier: "MoviesListTableViewCell")
    }
}

// MARK: UITableViewDelegate, UITableViewDataSource
extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MoviesListTableViewCell", for: indexPath) as? MoviesListTableViewCell else { return UITableViewCell() }
        cell.setupCell(movie: self.viewModel.dataSource[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.handleSelection(movie: self.viewModel.dataSource[indexPath.row])
    }
    
}
