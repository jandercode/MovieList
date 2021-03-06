//
//  MovieRow.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieRowPoster: View {
    
    let movie: Movie
    
    var body: some View {
        VStack {
            AsyncImage(url: movie.posterURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .shadow(radius: 8)
                case .empty:
                    Text(movie.title)
                case .failure(_):
                    Text(movie.title)
                @unknown default:
                    Text(movie.title)
                }
            }
            .frame(width: 204, height: 306)
            .cornerRadius(8)
            
            Text(movie.title)
                .font(.headline)
                .padding(.bottom, 10)
                .frame(width: 180, alignment: .leading)
                .lineLimit(1)
                .foregroundColor(.black)
        }
    }
}

//struct MovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRow()
//    }
//}
