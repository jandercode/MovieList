//
//  MovieDetailState.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-07.
//

import Foundation
import SwiftUI

class MovieDetailState: ObservableObject {
    
    @Published var movie: Movie?
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService.shared){
        self.apiService = apiService
    }
    
    func loadMovie(movieID: Int) {
        movie = nil
        
        apiService.fetchMovie(id: movieID) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let movie):
                    self.movie = movie
                }
            }
        }
    }
}
