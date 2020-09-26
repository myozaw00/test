//
//  MovieListView.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var store: MovieStore
    
    init() {
        store = MovieStore()
    }
    
    var body: some View {
        
        NavigationView {
            ZStack {
                ScrollView {
                    // 3
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                        ForEach(store.movies) { info in
                            MoviePosterRow(movieInfo: info)
                        }
                    }.padding(.horizontal)
                }
                                
                if store.isProcessing {
                    ProgressView()
                }
                
            }
            
            .onAppear {
                store.getMovies()
            }
            .alert(isPresented: $store.hasErrorOccured) {
                Alert(title: Text("ERROR!"), message: Text(store.errorMessage), dismissButton: .default(Text("Got it")))
            }
            
            
            .navigationBarTitle("Movies", displayMode: .large)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color.white)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        
        
        
    }
    
}

struct MovieListView_Previews: PreviewProvider {
    static var previews: some View {
        MovieListView()
    }
}
