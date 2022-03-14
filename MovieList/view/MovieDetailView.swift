//
//  MovieDetailView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieID: Int
    @ObservedObject var movieDetailState = MovieDetailState()
    @StateObject private var imageLoader = ImageLoader()
    
    //Load single movie
    var body: some View {
        VStack {
            if movieDetailState.movie != nil {
                HStack {
                    //TODO use ImageLoader
                    if imageLoader.image != nil {
                        Image(uiImage: imageLoader.image!)
                            .resizable()
                            .aspectRatio(2/3, contentMode: .fit)
                            .frame(width: 160, height: 240, alignment: .leading)
                    } else {
                        Text(movieDetailState.movie!.title)
                            .frame(width: 150, height: 220, alignment: .center)
                    }

                    VStack(alignment: .leading) {
                        Text(movieDetailState.movie!.title)
                            .bold()
                            .padding(.bottom, 10)
                        Text(movieDetailState.movie!.releaseDate ?? "")
                        Text(movieDetailState.movie!.rating)
                        Text(movieDetailState.movie!.genreText)
                        Text(String(movieDetailState.movie!.runtime ?? 0))
                    }
                    Spacer()
                }
                .onAppear {imageLoader.loadImage(url: movieDetailState.movie!.posterURL)}
                .padding()
                Text(movieDetailState.movie!.overview).padding()
                Spacer()
            }
            
        }
        .onAppear {movieDetailState.loadMovie(movieID: movieID)}
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
