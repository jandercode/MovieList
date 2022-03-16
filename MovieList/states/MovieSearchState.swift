//
//  MovieSearchState.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-10.
//

import Foundation

class MovieSearchState: ObservableObject {
    
    @Published var query = ""
    @Published var movies: [Movie]?
    
    let apiService: APIService
    
    init(apiService: APIService = APIService.shared) {
        self.apiService = apiService
    }
    
    func searchMovies(query: String) {
        
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let finalQuery = trimmedQuery.replacingOccurrences(of: " ", with: "%20")
        
        apiService.searchMovie(query: finalQuery) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    self.movies = response
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
