//
//  APIService.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-03.
//

import Foundation

struct APIService {
    
    
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
}
