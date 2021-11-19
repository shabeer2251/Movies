//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    private let viewModel: MovieDetailsViewModel

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleAndReleaseDateLabel: UILabel!
    @IBOutlet weak var castAndCrewLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var plotLAbel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var metacriticRatingButton: UIButton!
    @IBOutlet weak var rottenTomatosRatingButton: UIButton!
    @IBOutlet weak var imdbRatingButton: UIButton!
    
    
    // MARK: initialization
    init(viewModel: MovieDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.viewModel.handleBack()
    }
    
    @IBAction func imdbButtonAction(_ sender: Any) {
        self.viewModel.handleRatingSelection(ratingsType: RatingsType.imdb)
    }
    
    @IBAction func metaCriticButtonAction(_ sender: Any) {
        self.viewModel.handleRatingSelection(ratingsType: RatingsType.metaCritic)
    }
    
    @IBAction func rottenTomatoesButtonAction(_ sender: Any) {
        self.viewModel.handleRatingSelection(ratingsType: RatingsType.rottenTomatoes)
    }
    
    func setupRatingView() {
        imdbRatingButton.isHidden = !viewModel.availableRatingType(type: RatingsType.imdb)
        metacriticRatingButton.isHidden = !viewModel.availableRatingType(type: RatingsType.metaCritic)
        rottenTomatosRatingButton.isHidden = !viewModel.availableRatingType(type: RatingsType.rottenTomatoes)
        StyleKit.applyRoundCornerTheme(button: imdbRatingButton, title: "IMDB")
        StyleKit.applyRoundCornerTheme(button: metacriticRatingButton, title: "Meta Critic")
        StyleKit.applyRoundCornerTheme(button: rottenTomatosRatingButton, title: "Rotten Tomatoes")
        imdbRatingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        imdbRatingButton.titleLabel?.numberOfLines = 1
        metacriticRatingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        metacriticRatingButton.titleLabel?.numberOfLines = 1
        rottenTomatosRatingButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rottenTomatosRatingButton.titleLabel?.numberOfLines = 1
    }
    
    func setupUI() {
        setupRatingView()
        //TODO: embed everything in scrollview
        StyleKit.applyMediumLabelStyle(label: titleAndReleaseDateLabel)
        StyleKit.applyRegularLabelStyle(label: plotLAbel)
        StyleKit.applyMediumLabelStyle(label: genreLabel)
        StyleKit.applyMediumLabelStyle(label: castAndCrewLabel)
        StyleKit.applyRoundCornersAndShadowAroundView(view: imageView)
        StyleKit.applyMediumLabelStyle(label: ratingLabel)
        ratingLabel.text = "Ratings:"
        titleAndReleaseDateLabel.text = viewModel.getTitleWithReleaseDateText()
        genreLabel.text = viewModel.movie.genre
        castAndCrewLabel.text = viewModel.getCastAndCrew()
        plotLAbel.text = viewModel.movie.plot
        //TODO: handle empty image
        imageView.downloadContentFromUrl(url: viewModel.movie.poster ?? "")
    }
}
