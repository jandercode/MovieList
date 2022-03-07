//
//  MovieDetailState.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-07.
//

import Foundation

class MovieDetailState: ObservableObject {
    
    @Published var movie: Movie?
    
    let apiKey = "db29946214e0864bc36c9884882f57f2"
    let baseURL = "https://api.themoviedb.org/3"
    
    private let apiService: APIService
    
    init(apiService: APIService = APIService.shared){
        self.apiService = apiService
    }
    
    func loadMovie(movieID: Int) {
        let url = URL(string: "\(baseURL)/movie/\(movieID)?api_key=\(apiKey)&language=en-US&page=1")
        //print(url)
        movie = nil
        
        apiService.fetchMovie(url: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .failure(let error):
                    print(url!)
                    print(error)
                case .success(let movie):
                    self.movie = movie
                    //print(movies)
                }
            }
        }
    }
    
}
