//
//  NowPlaying_CollectionCell.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import UIKit

class NowPlaying_CollectionCell: UICollectionViewCell {

    @IBOutlet var movieImage: UIImageView!
    
    
    static let identifier = "NowPlaying_CollectionCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NowPlaying_CollectionCell", bundle: nil)
    }
    
    
    public func configure(movie: MovieInfo) {
        
        movie.poster_path.downloadImage { (tempImage) in
            DispatchQueue.main.async {
                self.movieImage.image = tempImage
                self.movieImage.layer.cornerRadius = 40
            }
        }
    }
    

}
