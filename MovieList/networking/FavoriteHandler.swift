//
//  FavoriteHandler.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-14.
//

import Foundation
import SwiftUI

class FavoriteHandler: ObservableObject {
    static let shared = FavoriteHandler()
    
    //TODO make this a singleton
    @Published var favoriteMovies = [Movie]()
    
    func inFavorites(movie: Movie) -> Bool {
        return favoriteMovies.contains(movie)
    }
    
    func addMovie(movie: Movie) {
        favoriteMovies.append(movie)
        print("added movie")
        print(favoriteMovies)
    }
    
    func deleteMovie(movie: Movie) {
        if let index = favoriteMovies.firstIndex(where: {$0 == movie} ) {
            favoriteMovies.remove(at: index)
            print("removed movie")
        }
    }
    
    
    
}
