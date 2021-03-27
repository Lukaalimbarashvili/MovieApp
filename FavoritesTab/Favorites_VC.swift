//
//  Favorites_VC.swift
//  MovieApp
//
//  Created by Lucas on 10/12/20.
//

import UIKit
import CoreData

class Favorites_VC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var favorites = [Movie]()
    
    var favoriteMovies = [MovieInfo](){
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    let response = APIResponse()
    
    override func viewWillAppear(_ animated: Bool) {
     
        favorites = []
        favoriteMovies = []
        fetchMovies()
        
        for item in favorites {
            response.getMovieById(id: item.id) { (info) in
                self.favoriteMovies.append(info)
            }
        }
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
}


extension Favorites_VC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favorites_id", for: indexPath) as! favoritesCell

        favoriteMovies[indexPath.row].poster_path.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.movieImage.image = image
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let VC = storyboard.instantiateViewController(identifier: "details_id") as! Details_VC
            response.getMovieById(id: favorites[indexPath.row].id) { (movie) in
                VC.tempMovie = movie
            }
            self.navigationController?.pushViewController(VC, animated: true)     
    }
    
}


extension Favorites_VC {
    func fetchMovies() {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            let movie = try context.fetch(request)
            favorites.append(contentsOf: movie)
            collectionView.reloadData()
        
        } catch {}
    }
}
