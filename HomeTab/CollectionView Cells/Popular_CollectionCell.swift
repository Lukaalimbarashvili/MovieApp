//
//  Popular_CollectionCell.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import UIKit

class Popular_CollectionCell: UICollectionViewCell {

    
    @IBOutlet var movieImage: UIImageView!
    
    static let identifier = "Popular_CollectionCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "Popular_CollectionCell", bundle: nil)
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
