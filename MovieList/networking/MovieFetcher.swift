//
//  MovieFetcher.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

//import Foundation
//
//class MovieFetcher: ObservableObject {
//
//    @Published var movies = [Movie]()
//    @Published var errorMessage: String? = nil
//    //@Published var movie: Movie?
//
//    let apiKey = "db29946214e0864bc36c9884882f57f2"
//    let baseURL = "https://api.themoviedb.org/3"
//
//    init() {
//        fetchAllMovies()
//
//    }
//
//    //TODO make func fetchMovie
//
//    func fetchAllMovies() {
//        errorMessage = nil
//        let service = APIService()
//        let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)&language=en-US&page=1")
//        service.fetchMovies(url: url) { [unowned self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .failure(let error):
//                    print(url!)
//                    self.errorMessage = error.localizedDescription
//                    print(error)
//                case .success(let movies):
//                    self.movies = movies
//                }
//            }
//        }
//    }
//}
