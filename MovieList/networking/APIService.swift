//
//  APIService.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-03.
//

import Foundation

struct APIService {
    
    static let shared = APIService()
    
    func fetchMovies(url: URL?, completion: @escaping(Result<[Movie], Error>) -> Void) {
        
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
            
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let movies = try decoder.decode(MovieResponse.self, from: data)
                    
                    completion(Result.success(movies.results))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    //TODO func fetchMovie
    func fetchMovie(url: URL?, completion: @escaping(Result<Movie, Error>) -> Void) {
        guard let url = url else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
            
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let movie = try decoder.decode(Movie.self, from: data)
                    
                    completion(Result.success(movie))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
    func searchMovie(query: String, completion: @escaping (Result<[Movie], Error>) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=db29946214e0864bc36c9884882f57f2&query=\(query)") else {
            let error = APIError.badURL
            completion(Result.failure(error))
            return
        }
        
        print(url)
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error as? URLError {
                completion(Result.failure(APIError.url(error)))
            } else if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(Result.failure(APIError.badResponse(statusCode: response.statusCode)))
            } else if let data = data {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let movies = try decoder.decode(MovieResponse.self, from: data)
                    
                    completion(Result.success(movies.results))
                } catch {
                    completion(Result.failure(APIError.parsing(error as? DecodingError)))
                }
            }
        }
        task.resume()
    }
    
}
