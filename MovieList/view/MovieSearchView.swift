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
        NavigationView {
            VStack {
                Text("")
                    .searchable(text: $searchText)
                    .onChange(of: searchText) { newValue in
                        if searchText != "" {
                            movieSearchState.searchMovies(query: searchText)
                        }
                    }
                List {
                    if movieSearchState.movies != nil {
                        ForEach(movieSearchState.movies!) {movie in
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieRow(movie: movie)
                            }
                        }
                    } 
                }
            }
        }.navigationTitle(Text("Search"))
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
