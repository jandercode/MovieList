//
//  MovieRowBackdrop.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-15.
//

import SwiftUI

struct MovieRowBackdrop: View {
    
    let movie: Movie
    
    var body: some View {
        LazyHStack {
            
            VStack {
                AsyncImage(url: movie.backdropURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .cornerRadius(8)
                            .shadow(radius: 4)
                    case .empty:
                        Text(movie.title)
                    case .failure(_):
                        Text(movie.title)
                    @unknown default:
                        Text(movie.title)
                    }
                }
                .aspectRatio(16/9, contentMode: .fit)
                .frame(height: 160)
                
                Text(movie.title)
                    .font(.headline)
                    .padding([.horizontal, .bottom], 10)
                    //.multilineTextAlignment(.leading)
                    .lineLimit(1)
                    .frame(width: 284, alignment: .leading)
                    .foregroundColor(.black)
                
            }
        }
    }
}

