//
//  CastTableViewCell.swift
//  MovieApp
//
//  Created by Lucas on 10/11/20.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var actorName: UILabel!
    
    var delegate : FilterMode?
    
    var tempMovieId: Int? {
        didSet {
                    
            let url = "\(AllURL.ApiConstant)\(tempMovieId!)/credits?\(AllURL.ApiKey)"
            APIResponse.get(url: url, completion: {  (response: Cast) in
                self.tempCast = response.cast
                
            })
        }
    }
    
    
    var tempCast = [actor]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self    
        collectionView.showsHorizontalScrollIndicator = false
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension CastTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempCast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cast_id1", for: indexPath) as! CastCollectionViewCell
        
        tempCast[indexPath.row].profile_path?.downloadImage { (image) in
            DispatchQueue.main.async {
                cell.castImage.image = image
            }
        }
        cell.actorName.text = tempCast[indexPath.row].name
        
        return cell
    }
    
}
