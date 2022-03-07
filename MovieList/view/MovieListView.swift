//
//  MovieListView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var nowPlayingState = MovieListState()
    @ObservedObject var popularState = MovieListState()
    @ObservedObject var upcomingState = MovieListState()
    @ObservedObject var topRatedState = MovieListState()
    
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Popular")) {
                    if popularState.movies != nil {
                        ForEach(popularState.movies!) {movie in
                            //send movie id
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieRow(movie: movie)
                            }
                        }

                    } else {
                        LoadingView()
                    }
                }
                Section(header: Text("Now Playing")) {
                    if nowPlayingState.movies != nil {
                        ForEach(nowPlayingState.movies!) {movie in
                            //send movie id
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieRow(movie: movie)
                            }
                        }

                    } else {
                        LoadingView()
                    }
                }
                Section(header: Text("Upcoming")) {
                    if upcomingState.movies != nil {
                        ForEach(upcomingState.movies!) {movie in
                            //send movie id
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieRow(movie: movie)
                            }
                        }

                    } else {
                        LoadingView()
                    }
                }
                Section(header: Text("Top Rated")) {
                    if topRatedState.movies != nil {
                        ForEach(topRatedState.movies!) {movie in
                            //send movie id
                            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                MovieRow(movie: movie)
                            }
                        }

                    } else {
                        LoadingView()
                    }
                }

            }
            .navigationBarTitle("Movies")
        }
        .onAppear {popularState.loadMovies(listType: "popular")}
        .onAppear {nowPlayingState.loadMovies(listType: "now_playing")}
        .onAppear {upcomingState.loadMovies(listType: "upcoming")}
        .onAppear {topRatedState.loadMovies(listType: "top_rated")}
    }
}

//struct MovieListView_Previews: PreviewProvider {
//    static var previews: some View {
//        //MovieListView()
//    }
//}
