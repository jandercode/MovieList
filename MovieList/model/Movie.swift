//
//  Movie.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import Foundation
import CoreData

struct MovieResponse: Decodable {
    
    let results: [Movie]
}


class Movie: Decodable, Identifiable, Equatable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        lhs.id == rhs.id
    }
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage: Double
    let runtime: Int?
    let releaseDate: String?
    let credits: MovieCredit?
    
    
    let genres: [MovieGenre]?
    
    
    var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
    
    var backdropURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var rating: String {
        //let rating = Int(voteAverage)
        return "\(Int(voteAverage))/10"
    }
    
    var ratingStars: String {
        let rating = Int(voteAverage)
        var ratingStars = ""
        for _ in 0..<rating {
            ratingStars += "★"
        }
        return ratingStars
    }
    
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var duration: String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        guard let runtime = runtime else {
            return "n/a"
        }
        return formatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
    }
    
    var releaseYear: String {
        guard let releaseDate = releaseDate else { return "n/a" }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-dd"
        guard let date = formatter.date(from: releaseDate) else { return "n/a" }
        formatter.dateFormat = "yyyy"
        return formatter.string(from: date)
    }
    
    var cast: [MovieCast]? {
        credits?.cast
    }
    
    var crew: [MovieCrew]? {
        credits?.crew
    }
    
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director" }
    }
    
    var producers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "producer" }
    }
}

struct MovieGenre: Decodable {
    
    let name: String
}

struct MovieCredit: Decodable {
    
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}
