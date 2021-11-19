//
//  MoviesListTableViewCell.swift
//  Movies
//
//  Created by Muhammed Shabeer on 19/11/21.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       setupUI()
    }
    
    func setupUI() {
        StyleKit.applyMediumLabelStyle(label: titleLabel, fontSize: 16)
        StyleKit.applyBoldLabelStyle(label: languageLabel, fontSize: 14)
        StyleKit.applyBoldLabelStyle(label: yearLabel, fontSize: 14)
    }
    
    func setupCell(movie: Movie) {
        self.titleLabel.text = movie.title
        self.languageLabel.text = movie.language
        self.yearLabel.text = movie.year
        self.posterImageView.downloadContentFromUrl(url: movie.poster ?? "")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView?.image = nil
    }
   
}
