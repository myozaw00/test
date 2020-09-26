//
//  AppConstants.swift
//  iOS
//
//  Created by Myo Zaw Oo on 29/07/2020.
//

import Foundation

struct AppConstants {
    
    static let API_KEY = "db85bc6bf1d96e2f47ac91af80e1d717"
    
    struct Url {
        
        static let BASE_URL = "https://api.themoviedb.org"
        static let POPULAR_MOVIES = "3/movie/popular"
        static let TOP_RATED_MOVIES = "3/movie/top_rated"
        static let NOW_PLAYING_MOVIES = "3/movie/now_playing"
        static let SIMILAR_MOVIES = "3/movie/{movie_id}/similar"
        static let MOVIE_TRAILER = "3/movie/{movie_id}/videos"
        static let MOVIE_DETAILS = "3/movie/{movie_id}"
        
    }
}
