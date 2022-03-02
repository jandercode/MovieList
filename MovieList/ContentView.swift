//
//  ContentView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var movieFetcher = MovieFetcher()
    
    //TODO add LoadingView, ErrorView
    var body: some View {
        MovieListView(movies: movieFetcher.movies)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
