//
//  similarMoviesTableViewCell.swift
//  MovieApp
//
//  Created by Lucas on 10/11/20.
//

import UIKit


protocol FilterMode {
    func getData(newMovie: MovieInfo)
}

class similarMoviesTableViewCell: UITableViewCell {
    

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var similarsLabel: UILabel!
    
    var delegate : FilterMode?
    
    var tempMovieId: Int? {
        didSet {
            let url = "\(AllURL.ApiConstant)\(tempMovieId!)/similar?\(AllURL.ApiKey)"
                APIResponse.get(url: url, completion: { (response: AllMovie) in
                    self.similarMovies = response.results
                    
                })
        }
    }
    
    var similarMovies = [MovieInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            if self.similarMovies.isEmpty {
//
//                    self.similarsLabel.text = "No similar Movies Found"
//
//            }
//        }
      
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}


extension similarMoviesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "similarmovies_id1", for: indexPath) as! similarMoviesCollectionViewCell
        
        similarMovies[indexPath.row].poster_path.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.mainImage.image = image
            }

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        delegate?.getData(newMovie: similarMovies[indexPath.row])
        
    }
    
}
