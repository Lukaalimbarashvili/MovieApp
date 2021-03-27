//
//  Popular_Api.swift
//  MovieApp
//
//  Created by Lucas on 10/9/20.
//

import Foundation

struct AllMovie: Codable {
    var results   :[MovieInfo]
    
    
}

struct MovieInfo: Codable {
    var poster_path    :String
    var id             :Int
    var backdrop_path  :String
    var original_title :String
    var overview       :String
    var release_date   :String
}
