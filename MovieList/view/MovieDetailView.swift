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
    
    //Load single movie
    var body: some View {
        VStack {
            if movieDetailState.movie != nil {
                HStack {
                    AsyncImage(url: URL(string: movieDetailState.movie!.posterURL)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 150, height: 220, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        Text(movieDetailState.movie!.title)
                            .bold()
                            .padding(.bottom, 10)
                        Text(movieDetailState.movie!.releaseDate ?? "")
                        Text(movieDetailState.movie!.rating)
                        Text(movieDetailState.movie!.genreText)
                    }
                    Spacer()
                }
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
