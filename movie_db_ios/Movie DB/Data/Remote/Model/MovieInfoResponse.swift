//
//  MovieInfoResponse.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import Foundation

struct MovieInfoResponse: Codable {
        let vote_count: Int?
        let id: Int?
        let video: Bool?
        let vote_average: Double?
        let title: String?
        let popularity: Double?
        let poster_path: String?
        let original_language: String?
        let original_title: String?        
        let backdrop_path: String?
        let adult: Bool?
        let overview: String?
        let release_date: String?
}
