//
//  MovieInfo.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import Foundation

struct MovieInfo: Identifiable {
    var id = UUID()
    let movieId: Int
    let movieTitle: String
    let movieOverview: String
    let releaseYear: String
    let coverPhoto: String
}

extension MovieInfo {
    static let demoData = MovieInfo(id: UUID(), movieId: 0, movieTitle: "This is title.", movieOverview: "This is overview.", releaseYear: "2020", coverPhoto: "https://i.ytimg.com/vi/4RKugUq7L8U/maxresdefault.jpg")
}
