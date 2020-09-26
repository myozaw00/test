//
//  MoviePosterView.swift
//  Movie DB
//
//  Created by Myo Zaw Oo on 26/09/2020.
//

import SwiftUI

struct MoviePosterRow: View {
    var movieInfo: MovieInfo
    let imageLoader = ImageLoader()
    @State var image: UIImage? = nil
    
    var body: some View {
        
        Group {
            makeContent()
        }.onReceive(imageLoader.objectWillChange, perform: { image in
            self.image = image
        })
        .onAppear(perform: {        
            self.imageLoader.load(url: URL(string: movieInfo.coverPhoto)!)
        })
        .onDisappear(perform: {
            self.imageLoader.cancel()
        })
    
    }
    
    private func makeContent() -> some View {
            if let image = image {
                return AnyView(
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                )
            } else {
                return AnyView(Image("movie_placeholder")
                                .resizable()
                                .aspectRatio(contentMode: .fit))
            }
        }
}

struct MoviePosterRow_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterRow(movieInfo: MovieInfo.demoData)
    }
}
