//
//  UserMapper.swift
//  iOS
//
//  Created by Myo Zaw Oo on 05/08/2020.
//

import Foundation

struct MovieMapper {
   
    static func mapMovies(data: [MovieInfoResponse]) -> [MovieInfo] {
        var list = [MovieInfo]()
        data.forEach {
            list.append(
                MovieInfo(movieId: $0.id ?? 0,
                        movieTitle: $0.original_title ?? "",
                        movieOverview: $0.overview ?? "",
                        releaseYear: DateUtils.convertDate(date: $0.release_date ?? "", fromDateFormat: "yyyy-MM-dd", toDateFormat: "yyyy"),
                        coverPhoto: "https://image.tmdb.org/t/p/w200\($0.poster_path ?? "")" ))
        }
        print("Count: \(list.count)")
        return list
    }
    
}
