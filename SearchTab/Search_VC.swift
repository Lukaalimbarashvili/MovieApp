//
//  Search_VC.swift
//  MovieApp
//
//  Created by Lucas on 10/10/20.
//

import UIKit


class CellClass: UITableViewCell {
    
}


class Search_VC: UIViewController {

    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let transparentView = UIView()
    let secondTableView = UITableView()
    
    
    let response = APIResponse()
    let url = AllURL()
    
    let searchTypes = ["Popular","Top Rated","Now Playing"]
    
    var searchMovies = [MovieInfo]()
    var searching = false
    
    var allMovie = [MovieInfo]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnSearch.layer.cornerRadius = 15
        secondTableView.delegate = self
        secondTableView.dataSource = self
        secondTableView.register(CellClass.self, forCellReuseIdentifier: "Celll")
    }
    
    @IBAction func onSearch(_ sender: Any) {
        addTransparentView()
    }
    
    func addTransparentView() {
        let window = UIApplication.shared.keyWindow
        transparentView.frame = window?.frame ?? self.view.frame
        self.view.addSubview(transparentView)
        
        secondTableView.frame = CGRect(x: btnSearch.frame.origin.x, y: btnSearch.frame.origin.y + btnSearch.frame.height , width: btnSearch.frame.width, height: 0)
        
        self.view.addSubview(secondTableView)
        secondTableView.layer.cornerRadius = 7
        
        transparentView.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        secondTableView.reloadData()
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeTransparentView))
        transparentView.addGestureRecognizer(tapgesture)
        
        transparentView.alpha = 0
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.5
            self.secondTableView.frame = CGRect(x: self.btnSearch.frame.origin.x, y: self.btnSearch.frame.origin.y + self.btnSearch.frame.height + 5 , width: self.btnSearch.frame.width, height: 150)
        }, completion: nil )
    
  

}

    @objc func removeTransparentView() {
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 1.0, options: .curveEaseInOut, animations: {
            self.transparentView.alpha = 0.0
            self.secondTableView.frame = CGRect(x: self.btnSearch.frame.origin.x, y: self.btnSearch.frame.origin.y + self.btnSearch.frame.height , width: self.btnSearch.frame.width, height: 0)
        }, completion: nil )
    }
}


extension Search_VC: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Celll", for: indexPath) as! CellClass
        cell.textLabel?.text = searchTypes[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = cell.textLabel?.font.withSize(17)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        btnSearch.setTitle(searchTypes[indexPath.row], for: .normal)
        
        if indexPath.row == 0 {
            response.GetMovie(url: AllURL.popular) { (populars) in
                self.allMovie = populars.results
                self.searching = false
            }
        }
        if indexPath.row == 1 {
            response.GetMovie(url: AllURL.topRated) { (toprated) in
                self.allMovie = toprated.results
                self.searching = false
            }
        }
        if indexPath.row == 2 {
            response.GetMovie(url: AllURL.nowPlaying) { (nowplaying) in
                self.allMovie = nowplaying.results
                self.searching = false
            }
        }
        
        removeTransparentView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}









extension Search_VC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searching ?  searchMovies.count :  allMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesCell_id", for: indexPath) as! movies_collectionCell
        
        if searching {
            searchMovies[indexPath.row].poster_path.downloadImage(completion: { (image) in
                   DispatchQueue.main.async {
                    cell.movieImage.image = image
                    cell.movieName.text = self.searchMovies[indexPath.row].original_title
                    cell.movieImage.layer.cornerRadius = 40
                   }
                })
            
        } else {
            allMovie[indexPath.row].poster_path.downloadImage(completion: { (image) in
                   DispatchQueue.main.async {
                       cell.movieImage.image = image
                       cell.movieName.text = self.allMovie[indexPath.row].original_title
                       cell.movieImage.layer.cornerRadius = 40
                   }
            })
        }
       
        return cell
    }
}


extension Search_VC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchMovies = allMovie.filter({$0.original_title.lowercased().prefix(searchText.count) == searchText.lowercased()})
        searching = true
        self.collectionView.reloadData()
        
    }
}
