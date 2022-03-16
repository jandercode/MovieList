//
//  MovieListView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieHomeView: View {
    
    @ObservedObject var nowPlayingState = MovieListState()
    @ObservedObject var popularState = MovieListState()
    @ObservedObject var upcomingState = MovieListState()
    @ObservedObject var topRatedState = MovieListState()
    
    
    var body: some View {

            List {
                Group {
                    if popularState.movies != nil {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Popular")
                                .font(.title)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(popularState.movies!) {movie in
                                        NavigationLink(destination: MovieDetailView(movieID: movie.id, movieTitle: movie.title)) {
                                            MovieRowPoster(movie: movie)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        LoadingView()
                    }
                }
                .padding(.bottom, 20)
                .listRowSeparator(.hidden)
                
                Group {
                    if nowPlayingState.movies != nil {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Now Playing")
                                .font(.title)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(nowPlayingState.movies!) {movie in
                                        NavigationLink(destination: MovieDetailView(movieID: movie.id, movieTitle: movie.title)) {
                                            MovieRowBackdrop(movie: movie)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        LoadingView()
                    }
                }
                .padding(.bottom, 20)
                .listRowSeparator(.hidden)
                Group {
                    if upcomingState.movies != nil {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Upcoming")
                                .font(.title)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(upcomingState.movies!) {movie in
                                        NavigationLink(destination: MovieDetailView(movieID: movie.id, movieTitle: movie.title)) {
                                            MovieRowPoster(movie: movie)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        LoadingView()
                    }
                }
                .padding(.bottom, 20)
                .listRowSeparator(.hidden)
                Group {
                    if topRatedState.movies != nil {
                        VStack(alignment: .leading, spacing: 10) {
                            Text("Top Rated")
                                .font(.title)
                                .fontWeight(.bold)
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack{
                                    ForEach(topRatedState.movies!) {movie in
                                        NavigationLink(destination: MovieDetailView(movieID: movie.id, movieTitle: movie.title)) {
                                            MovieRowBackdrop(movie: movie)
                                        }
                                    }
                                }
                            }
                        }
                    } else {
                        LoadingView()
                    }
                }
                .padding(.bottom, 20)
                .listRowSeparator(.hidden)
                
            }
            .listStyle(.plain)
            .navigationTitle("The Movie List")
            
            .onAppear(perform: {popularState.loadMovies(listType: "popular")})
            .onAppear(perform: {nowPlayingState.loadMovies(listType: "now_playing")})
            .onAppear(perform: {upcomingState.loadMovies(listType: "upcoming")})
            .onAppear(perform: {topRatedState.loadMovies(listType: "top_rated")})
    }
}


