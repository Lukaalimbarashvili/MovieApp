//
//  Details_VC.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import FaveButton
import UIKit
import CoreData


class Details_VC: UIViewController, FilterMode {
    
    
    
    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var favButton: FaveButton!
    
    
    var tempMovie :MovieInfo?
    var favoriteMovie = false
    var tempItem: Movie?
    
    
    
    var favorites = [Movie]() {
        didSet {
            for item in favorites {
                if item.id == tempMovie!.id {
                    self.favButton.setSelected(selected: true, animated: true)
                    self.tempItem = item
                    self.favoriteMovie = true
                }
                
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainTableView.showsVerticalScrollIndicator = false
        
        fetchMovies()
        
        tempMovie!.backdrop_path.downloadImage { (tempImage) in
            DispatchQueue.main.async {
                self.mainImageView.image = tempImage
                
            }
        }
        
        
    }
    
    
    @IBAction func onBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onFavorite(_ sender: Any) {
        if favoriteMovie {
            deleteMovie(favMovie: tempItem!)
        } else {
            addFavoriteMovie()
        }
        
    }
    
    func getData(newMovie: MovieInfo) {
        self.tempMovie = newMovie
        tempMovie!.backdrop_path.downloadImage { (tempImage) in
            DispatchQueue.main.async {
                self.mainImageView.image = tempImage
                
            }
        }
        favoriteMovie = false
        self.loadView()
    }
    
}

extension Details_VC : UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieinfo_id", for: indexPath) as! infoTableViewCell
            cell.selectionStyle = .none
            cell.movieName.text = tempMovie?.original_title
            cell.movieOverview.text = tempMovie?.overview
            cell.movieReleaseDate.text = tempMovie?.release_date
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "similarmovies_id", for: indexPath) as! similarMoviesTableViewCell
            cell.selectionStyle = .none
            cell.tempMovieId = tempMovie?.id
            cell.delegate = self
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cast_id", for: indexPath) as! CastTableViewCell
            cell.selectionStyle = .none
            cell.tempMovieId = tempMovie?.id
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
            
        }
        
    }
    
 
}

extension Details_VC {
    func addFavoriteMovie() {
        let context = AppDelegate.coreDataContainer.viewContext
        let newMovie = Movie(context: context)
        
        newMovie.id = Int32(tempMovie!.id)
        newMovie.favorite = true
        
        do {
            try context.save()
        } catch {}
    }
    
    func fetchMovies() {
        let context = AppDelegate.coreDataContainer.viewContext
        
        let request: NSFetchRequest<Movie> = Movie.fetchRequest()
        
        do {
            let movie = try context.fetch(request)
            favorites.append(contentsOf: movie)
            
        } catch {}
    }
    
    func deleteMovie(favMovie: Movie) {
        let context = AppDelegate.coreDataContainer.viewContext
        context.delete(favMovie)
        
        do {
            try context.save()
        } catch {}
    }
}
