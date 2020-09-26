//
//  UserRepository.swift
//  Digital Onboard
//
//  Created by Myo Zaw Oo on 17/08/2020.
//

import Foundation
import Combine

struct MovieRepository {
    
    func getMovies() -> AnyPublisher<[MovieInfo], Error> {        
        return MovieAPI.getMovies()
            .tryMap({ (data: [MovieInfoResponse]) -> [MovieInfo] in
                let movies = MovieMapper.mapMovies(data: data)
                return movies
            }).eraseToAnyPublisher()
    }
    
}
