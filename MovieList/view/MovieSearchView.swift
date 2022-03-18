//
//  MovieSearchView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-09.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchState = MovieSearchState()
    @State var searchText = ""
    
    var body: some View {
        
        List {
            if movieSearchState.movies != nil {
                ForEach(movieSearchState.movies!) {movie in
                    NavigationLink(destination: MovieDetailView(movieID: movie.id, movieTitle: movie.title)) {
                        MovieRowSearch(movie: movie)
                    }
                }
            }
        }
        .navigationTitle(Text("Search"))
        .searchable(text: $searchText)
        .listStyle(.plain)
        .onChange(of: searchText) { newValue in
            if searchText != "" {
                movieSearchState.searchMovies(query: searchText)
            }
        }
    }
}
