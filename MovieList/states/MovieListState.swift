//
//  MovieListState.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-07.
//

import Foundation

class MovieListState: ObservableObject {
    
    @Published var movies: [Movie]?
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService.shared){
        self.apiService = apiService
    }
    
    func loadMovies(listType: String) {
        movies = nil
        self.isLoading = true
        
        apiService.fetchMovies(listType: listType) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage!)
                case .success(let movies):
                    self.movies = movies
                }
            }
        }
    }
}
