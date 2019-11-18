//
//  MovieDetailCell.swift
//  veryCreativeTask
//
//  Created by Isha Goel on 17/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import UIKit

class MovieDetailCell: UITableViewCell {

    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var adultLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var castLabel: UILabel!
    
    public static var nib: UINib {
        return UINib(nibName: "MovieDetailCell", bundle: Bundle(for: MovieDetailCell.self))
    }
    
    public var movie: Movie? {
        didSet {
            guard let movie = movie else {
                return
            }
            
            taglineLabel.text = "Tagline: \(movie.tagline ?? "No tag")"
            
            adultLabel.isHidden = !movie.adult
            
            durationLabel.text = "Duration: \(movie.runtime ?? 0) mins"
            if let genres = movie.genres, genres.count > 0 {
                genreLabel.isHidden = false
                genreLabel.text = genres.map { $0.name }.joined(separator: ", ")
            } else {
                genreLabel.isHidden = true
            }
            
            if let casts = movie.credits?.cast, casts.count > 0 {
                castLabel.isHidden = false
                castLabel.text = "Cast: \(casts.prefix(upTo: 3).map { $0.name }.joined(separator: ", "))"
            } else {
                castLabel.isHidden = true
            }
        }
    }
}
