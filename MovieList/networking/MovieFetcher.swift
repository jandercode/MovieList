//
//  MovieFetcher.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import Foundation

class MovieFetcher: ObservableObject {
    
    @Published var movies = [Movie]()
    
    init() {
        fetchAllMovies()
    }
    
    //TODO fetchMovie func
    
    func fetchAllMovies() {
        //TODO show errors
        //TODO make loadURLAndDecode func
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=db29946214e0864bc36c9884882f57f2&language=en-US&page=1")!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            if let data = data {
        
                do {
                    let movies = try decoder.decode(MovieResponse.self, from: data)
                    
                    DispatchQueue.main.async{
                        self.movies = movies.results
                        //print(self.movies)
                    }
                    
                } catch {
                    //TODO show error
                    print(error)
                }
            }
        }
        task.resume()
    }
    
}
