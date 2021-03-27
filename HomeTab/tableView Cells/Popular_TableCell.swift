//
//  SecondTableViewCell.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import UIKit

class Popular_TableCell: UITableViewCell {

    static let identifier = "Popular_TableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "Popular_TableCell", bundle: nil)
    }
    
    var didSelectItemAction: ((IndexPath) -> Void)?
    
    @IBOutlet weak var latestTrailersSector: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    

    var UpComingMovies = [MovieInfo]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(Popular_CollectionCell.nib(), forCellWithReuseIdentifier: Popular_CollectionCell.identifier)
        
        collectionView.delegate   = self
        collectionView.dataSource = self
        
    }

    func configure(movie :[MovieInfo]) {
        self.UpComingMovies = movie
        collectionView.reloadData()
    }
}

extension Popular_TableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UpComingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Popular_CollectionCell.identifier, for: indexPath) as! Popular_CollectionCell
        cell.configure(movie: UpComingMovies[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
    }
    
    
}

