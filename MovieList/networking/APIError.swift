//
//  APIError.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-03.
//

import Foundation

enum APIError: Error, CustomStringConvertible {
    case badURL
    case badResponse(statusCode: Int)
    case url(URLError?)
    case parsing(DecodingError?)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .badURL, .parsing, .unknown:
            return "Something went wrong."
        case .badResponse(_):
            return "The connetion to the server failed."
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        }
    }
    var description: String {
        switch self {
        case .unknown: return "unkown error"
        case .badURL: return "invalid url"
        case .url(let error):
            return error?.localizedDescription ?? "url session error"
        case .parsing(let error):
            return "parsing error \(error?.localizedDescription ?? "")"
        case .badResponse(statusCode: let statusCode):
            return "bad response with status code \(statusCode)"
        }
    }
}
