//
//  MovieListView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-16.
//

import SwiftUI

struct MovieListView: View {
    
    let movies: [Movie]?
    let listType: String
    var poster: Bool = false
    
    var body: some View {
        if let movies = movies {
            VStack(alignment: .leading, spacing: 14) {
                Text(listType)
                    .font(.title)
                    .fontWeight(.bold)
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack (alignment: .top, spacing: 16){
                        ForEach(movies) {movie in
                            NavigationLink(destination: MovieDetailView(movieID: movie.id, movieTitle: movie.title)) {
                                if poster {
                                    MovieRowPoster(movie: movie)
                                } else {
                                    MovieRowBackdrop(movie: movie)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 20)
            .listRowSeparator(.hidden)
        } else {
            LoadingView()
        }
    }

}
