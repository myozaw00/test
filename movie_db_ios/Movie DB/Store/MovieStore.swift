//
//  BaseStore.swift
//  iOS
//
//  Created by Myo Zaw Oo on 05/08/2020.
//

import Foundation
import Combine

class MovieStore: ObservableObject {
    
    @Published var errorMessage: String = ""
    @Published var hasErrorOccured: Bool = false
    @Published var isProcessing: Bool = false
    private let movieRepository = MovieRepository()
    @Published var movies = [MovieInfo]()
    
    var subscriptions: Set<AnyCancellable> = []
    
    func showLoading() {
        isProcessing = true
    }
    
    func dismissLoading() {
        isProcessing = false
    }
    
}

extension MovieStore {
    
    func getMovies() {
        showLoading()
        return movieRepository.getMovies()
            .sink(receiveCompletion: { completion in
                self.dismissLoading()
                switch completion {
                
                case .failure(let error as ApiError):do {
                    self.hasErrorOccured = true
                    self.errorMessage = error.localizedDescription
                }
                
                case .finished:
                    print("onFinished has arrived")
                    
                case .failure(let error): do {
                    self.hasErrorOccured = true
                    self.errorMessage = error.localizedDescription
                    print(error.localizedDescription)
                }
                }
            }, receiveValue: { (data: [MovieInfo]) in
                self.dismissLoading()
                self.movies = data
            }).store(in: &subscriptions)
    }
}
