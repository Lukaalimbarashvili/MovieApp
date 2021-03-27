//
//  Home_VC.swift
//  MovieApp
//
//  Created by Lucas on 10/8/20.
//

import UIKit

class Home_VC: UIViewController {

    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var mainTableView: UITableView!
    
    let searchTypes = ["Popular","Top Rated","UpComing"]
    let sectorNames = ["What's Popular","Top Rated","Now Playing"]

    var PopularMovies  =  [MovieInfo]()
    var TopRatedMovies = [MovieInfo]()
    var NowPlayingMovies = [MovieInfo]()
    var allMovie       = [MovieInfo]() {
        didSet {
            allMovie.randomElement()?.backdrop_path.downloadImage(completion: { (image) in
                DispatchQueue.main.async {
                    self.mainImageView.image = image
                }
            })
        }
    }
    let darkBlue = UIColor(red: 2.0/255.0, green: 62.0/255.0, blue: 94.0/255.0, alpha: 0.6)
    let lightBlue = UIColor(red: 1.0/255.0, green: 125.0/255.0, blue: 166.0/255.0, alpha: 0.6)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.showsVerticalScrollIndicator = false
        mainImageView.layer.cornerRadius = 20
        
        loadData()
   
        let gold = UIColor(hex: "#ffe700ff")

        
        mainTableView.register(TopRated_TableCell.nib(), forCellReuseIdentifier: TopRated_TableCell.identifier)
        mainTableView.register(Popular_TableCell.nib(), forCellReuseIdentifier: Popular_TableCell.identifier)
        mainTableView.register(NowPlaying_TableCell.nib(), forCellReuseIdentifier: NowPlaying_TableCell.identifier)

        mainImageView.gradient(firstColor: darkBlue, secondColor: lightBlue)
        mainTableView.backgroundColor = gold
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.reloadData()
    }
    
    private func setupTableViewCell(nibName:String, id:String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        mainTableView.register(nib, forCellReuseIdentifier: id)
    }
    
    

}


extension Home_VC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: TopRated_TableCell.identifier, for: indexPath) as! TopRated_TableCell
                cell.selectionStyle = .none
                cell.whatsPopularSector.text = sectorNames[0]
                cell.configure(movie: PopularMovies)
                cell.didSelectItemAction = { [weak self] indexPath in
                    let detailVC = self?.storyboard?.instantiateViewController(identifier: "details_id") as! Details_VC
                    detailVC.tempMovie = cell.PopularMovies[indexPath.row]
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
                return cell
            }
            if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: Popular_TableCell.identifier, for: indexPath) as! Popular_TableCell
                cell.selectionStyle = .none
                cell.latestTrailersSector.text = sectorNames[1]
                cell.configure(movie: TopRatedMovies)
                cell.didSelectItemAction = { [weak self] indexPath in
                    let detailVC = self?.storyboard?.instantiateViewController(identifier: "details_id") as! Details_VC
                    detailVC.tempMovie = cell.UpComingMovies[indexPath.row]
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
                return cell
            }
    
                let cell = tableView.dequeueReusableCell(withIdentifier: NowPlaying_TableCell.identifier, for: indexPath) as! NowPlaying_TableCell
                cell.selectionStyle = .none
                cell.trendingSector.text = sectorNames[2]
                cell.configure(movie: NowPlayingMovies)
                cell.didSelectItemAction = { [weak self] indexPath in
                    let detailVC = self?.storyboard?.instantiateViewController(identifier: "details_id") as! Details_VC
                    detailVC.tempMovie = cell.TopRatedMovie[indexPath.row]
                    self?.navigationController?.pushViewController(detailVC, animated: true)
                }
                return cell
            
        }

    
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 340
    }
    
}


extension Home_VC {
    func loadData() {
        APIResponse.get(url: AllURL.popular, completion: { (response: AllMovie) in
            self.PopularMovies = response.results
            self.allMovie.append(contentsOf: response.results)
        })
        
        APIResponse.get(url: AllURL.topRated, completion: { (response: AllMovie) in
            self.TopRatedMovies = response.results
            self.allMovie.append(contentsOf: response.results)
        })

        APIResponse.get(url: AllURL.nowPlaying, completion: { (response: AllMovie) in
            self.NowPlayingMovies = response.results
            self.allMovie.append(contentsOf: response.results)
        })
    }
}


