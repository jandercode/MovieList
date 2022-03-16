//
//  MovieListView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieHomeView: View {
    
    @ObservedObject var popularState = MovieListState()
    @ObservedObject var nowPlayingState = MovieListState()
    @ObservedObject var upcomingState = MovieListState()
    @ObservedObject var topRatedState = MovieListState()
    
    var body: some View {

            List {
                MovieListView(movies: popularState.movies, listType: "Popular", poster: true)
                MovieListView(movies: nowPlayingState.movies, listType: "Now Playing")
                MovieListView(movies: upcomingState.movies, listType: "Upcoming", poster: true)
                MovieListView(movies: topRatedState.movies, listType: "Top Rated")
            }
            .listStyle(.plain)
            .navigationTitle("The Movie List")
            .onAppear(perform: {popularState.loadMovies(listType: "popular")})
            .onAppear(perform: {nowPlayingState.loadMovies(listType: "now_playing")})
            .onAppear(perform: {upcomingState.loadMovies(listType: "upcoming")})
            .onAppear(perform: {topRatedState.loadMovies(listType: "top_rated")})
    }
}


