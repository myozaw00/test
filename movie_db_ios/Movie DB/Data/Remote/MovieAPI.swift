//
//  MovieAPI.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import Combine
import Foundation

enum MovieAPI {
    static let agent = Agent()
    static let base = URL(string: AppConstants.Url.BASE_URL)!
}

extension MovieAPI {
    
    static func getMovies() -> AnyPublisher<[MovieInfoResponse], Error> {
        
        let url = "\(AppConstants.Url.BASE_URL)/\(AppConstants.Url.POPULAR_MOVIES)?api_key=\(AppConstants.API_KEY)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        var urlRequest = URLRequest(url: URL(string: url)!)
        urlRequest.httpMethod = "GET"
        
        return agent.run(urlRequest)
            .tryMap { (data: Agent.Response<PopularMovieResponse>) -> [MovieInfoResponse] in
                print("data: \(data)")
                guard let httpResponse = data.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw ApiError.init(errorMessage: data.value.status_message ?? "")
                }
                
                return data.value.results ?? []
            }.eraseToAnyPublisher()

    }
    
}
