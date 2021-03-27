//
//  ThirdTableViewCell.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import UIKit

class NowPlaying_TableCell: UITableViewCell {
    
    static let identifier = "NowPlaying_TableCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "NowPlaying_TableCell", bundle: nil)
    }
    
    var didSelectItemAction: ((IndexPath) -> Void)?

    @IBOutlet weak var trendingSector: UILabel!
    
    @IBOutlet var collectionView: UICollectionView!
    
    var TopRatedMovie = [MovieInfo]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.showsHorizontalScrollIndicator = false
        
        collectionView.register(NowPlaying_CollectionCell.nib(), forCellWithReuseIdentifier: NowPlaying_CollectionCell.identifier)
        
        collectionView.delegate   = self
        collectionView.dataSource = self
        
    }

    func configure(movie :[MovieInfo]) {
        self.TopRatedMovie = movie
        collectionView.reloadData()
    }
    
}

extension NowPlaying_TableCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return TopRatedMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlaying_CollectionCell.identifier, for: indexPath) as! NowPlaying_CollectionCell
        cell.configure(movie: TopRatedMovie[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectItemAction?(indexPath)
    }
    
}
