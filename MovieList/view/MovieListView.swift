//
//  MovieListView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieListView: View {
    
    //nowPlayingState = MovieListState()
    //popularState = MovieListState()
    //upcomingState = MovieListState()
    //topRatedState = MovieListState()
    
    let movies: [Movie]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    //send movie id
                    NavigationLink(destination: MovieDetailView(movie: movie)) {
                        MovieRow(movie: movie)
                    }
                    
                }
            }
            .navigationBarTitle("Popular")
        }
    }
}

//struct MovieListView_Previews: PreviewProvider {
//    static var previews: some View {
//        //MovieListView()
//    }
//}
