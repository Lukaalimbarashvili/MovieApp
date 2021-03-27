//
//  ApiResponse.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import Foundation



class AllURL {
    static let ApiKey = "api_key=c27503c748760190c16d3d881e5d366c&language=en-US&page=1"
    static let ApiConstant = "https://api.themoviedb.org/3/movie/"
    
    static let topRated = "\(ApiConstant)top_rated?\(ApiKey)"
    static let popular = "\(ApiConstant)popular?\(ApiKey)"
    static let nowPlaying = "\(ApiConstant)now_playing?\(ApiKey)"
}
struct APIResponse {
    
    static func get<T: Codable>(url: String, completion: @escaping (T)->Void) {
        
        guard let url = URL(string: url) else {return}
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            
            guard let data = data else {return}
            
            do {
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                
                completion(decodedData)
            } catch let err {
                print("failed to decode json \(err)")
            }
            
        }.resume()
    }
    
    func GetMovie(url: String, completion: @escaping (AllMovie)->())
    {

            guard let url = URL(string: url) else{return}

            URLSession.shared.dataTask(with: url){(data,res,err) in
            guard let data = data else{return}

            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(AllMovie.self, from: data)

                completion(response)


            }catch{print(error.localizedDescription)}

            }.resume()
       }

   static  func getCast(id : Int, completion: @escaping (Cast)->()){

            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)/credits?api_key=c27503c748760190c16d3d881e5d366c") else{return}

            URLSession.shared.dataTask(with: url){(data,res,err) in
            guard let data = data else{return}

            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(Cast.self, from: data)

                completion(response)


            }catch{print(error.localizedDescription)}

            }.resume()
       }
    
    
    func getMovieById(id : Int32, completion: @escaping (MovieInfo)->()){
        
            guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(id)?api_key=c27503c748760190c16d3d881e5d366c&language=en-US") else{return}

            URLSession.shared.dataTask(with: url){(data,res,err) in
            guard let data = data else{return}

            do{
                let decoder = JSONDecoder()
                let response = try decoder.decode(MovieInfo.self, from: data)

                completion(response)


            }catch{print(error.localizedDescription)}

            }.resume()
       }

}
