//
//  MovieRowSearch.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-15.
//

import SwiftUI

struct MovieRowSearch: View {
    let movie: Movie
    
    var body: some View {
        HStack {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 4)
                case .empty:
                    Text(movie.title)
                case .failure(_):
                    Text(movie.title)
                @unknown default:
                    Text(movie.title)
                }
            }
            .frame(width: 174, height: 261, alignment: .center)
            .cornerRadius(8)
            
            VStack {
                Spacer()
                Text(movie.title)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .multilineTextAlignment(.leading)
                    .font(.headline)
                    .padding(.bottom, 2)
                    .foregroundColor(.black)
                
                Text(movie.releaseYear)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundColor(.black)
                    .padding(.bottom, 25)
                
                Text(movie.ratingStars)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundColor(.yellow)
                Text(movie.rating)
                    .frame(maxWidth: .infinity ,alignment: .leading)
                    .foregroundColor(.gray)
                Spacer()
                
            }.frame(maxWidth: .infinity, alignment: .leading)
        }.frame(height: 270, alignment: .leading)
    }
}

