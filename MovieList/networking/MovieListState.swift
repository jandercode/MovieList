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
    
    let apiKey = "db29946214e0864bc36c9884882f57f2"
    let baseURL = "https://api.themoviedb.org/3"
    
    
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService.shared){
        self.apiService = apiService
    }
    
    
    func loadMovies(listType: String) {
        let url = URL(string: "\(baseURL)/movie/\(listType)?api_key=\(apiKey)&language=en-US&page=1")
        //print(url)
        movies = nil
        self.isLoading = true
        
        apiService.fetchMovies(url: url) { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .failure(let error):
                    //print(url!)
                    self.errorMessage = error.localizedDescription
                    print(self.errorMessage!)
                case .success(let movies):
                    self.movies = movies
                    print(url)
                }
            }
        }
    }
}
