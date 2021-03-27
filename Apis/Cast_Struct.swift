//
//  Cast_Struct.swift
//  MovieApp
//
//  Created by Lucas on 10/11/20.
//

import Foundation


struct Cast: Codable {
    let cast: [actor]
}

struct actor: Codable {
    let name: String
    let profile_path: String?
}
