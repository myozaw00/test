//
//  PopularMovieResponse.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import Foundation

struct PopularMovieResponse: Codable {
    let page: Int?
    let total_results: Int?
    let total_pages: Int?
    let results: [MovieInfoResponse]?
    let status_code: Int?
    let status_message: String?
}
