//
//  SearchTypeItemTableViewCell.swift
//  Movies
//
//  Created by Muhammed Shabeer on 18/11/21.
//

import UIKit

class SearchTypeItemTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
   
    @IBOutlet weak var seperatorView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    func setupUI() {
        seperatorView.backgroundColor = UIColor.lightGray
        StyleKit.applyMediumLabelStyle(label: titleLabel, fontSize: 20)
    }
    
    
    func setupCell(title: String) {
        self.titleLabel.text = title
    }
}
