//
//  MovieCell.swift
//  veryCreativeTask
//
//  Created by Isha Goel on 17/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!

    func configure(_ movie: Movie) {
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(with: movie.posterURL)
    }
}
