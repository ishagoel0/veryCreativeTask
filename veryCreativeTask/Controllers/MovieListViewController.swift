//
//  MovieListViewController.swift
//  veryCreativeTask
//
//  Created by Isha Goel on 17/11/19.
//  Copyright © 2019 IG. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    @IBOutlet weak var gradePicker: UIPickerView!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var refreshButton: UIButton!
    
    var endpoint: Endpoint!
    var movieId : Int?
    var movieService: MovieService = MovieStore.shared
    var movies = [Movie]() {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let pickerValues = ["Now Playing", "Upcoming", "Popular", "Top Rated", "Favourite"]
    let endpoints: [Endpoint] = [.nowPlaying, .upcoming, .popular, .topRated, .favourite]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightButtonItem = UIBarButtonItem.init(
            title: "SORT",
            style: .done,
            target: self,
            action: #selector(rightButtonAction(sender:))
        )
        endpoint = endpoints[0]
        title = pickerValues[0]
        gradePicker.isHidden = true
        self.navigationItem.rightBarButtonItem = rightButtonItem
        collectionView.register(UINib(nibName: "MovieCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        fetchMovies()
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem){
        gradePicker.isHidden = false
    }
    
    private func fetchMovies() {
        guard let endpoint = endpoint else {
            return
        }
        
        activityIndicator.startAnimating()
        activityIndicator.isHidden = false
        hideError()
        
            movieService.fetchMovies(from: endpoint, params: nil, successHandler: { [unowned self] (response) in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.movies = response.results
            }) { [unowned self] (error) in
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.showError(error.localizedDescription)
            }
    }
    
    private func showError(_ error: String) {
        infoLabel.text = error
        infoLabel.isHidden = false
        refreshButton.isHidden = false
    }
    
    private func hideError() {
        infoLabel.isHidden = true
        refreshButton.isHidden = true
    }
    
    @IBAction func refreshTapped(_ sender: Any) {
        fetchMovies()
    }
}

extension MovieListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.size.width)/2, height: (collectionView.bounds.size.width)/2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        cell.configure(movie)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        movieId = movies[indexPath.item].id
        performSegue(withIdentifier: "MovieDetailViewControllerSegue", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as? MovieDetailViewController
        vc?.movieId = movieId
    }
    
}
    
extension MovieListViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        return pickerValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        endpoint = endpoints[row]
        title = pickerValues[row]
        gradePicker.isHidden = true
    }
}


