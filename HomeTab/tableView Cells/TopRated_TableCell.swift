//
//  FirstTableViewCell.swift
//  MovieApp
//
//  Created by Lucas on 10/8/20.
//

import UIKit

class TopRated_TableCell: UITableViewCell {
    
    static let identifier = "TopRated_TableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "TopRated_TableCell", bundle: nil)
    }
    
    var didSelectItemAction: ((IndexPath) -> Void)?

   
    @IBOutlet weak var whatsPopularSector: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var PopularMovies = [MovieInfo]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(TopRated_CollectionCell.nib(), forCellWithReuseIdentifier: TopRated_CollectionCell.identifier)
        
        collectionView.delegate   = self
        collectionView.dataSource = self
        
    }

    func configure(movie :[MovieInfo]) {
        self.PopularMovies = movie
        self.collectionView.reloadData()
    }
    
}

extension TopRated_TableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PopularMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRated_CollectionCell.identifier, for: indexPath) as! TopRated_CollectionCell
        cell.configure(movie: PopularMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        didSelectItemAction?(indexPath)
    }
    
    
}
