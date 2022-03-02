//
//  MovieRow.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieRow: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            
            if movie.posterPath != nil {
                
                AsyncImage(url: URL(string: movie.posterURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                    .frame(width: 150, height: 220, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 5) {
                    Spacer()
                    
                    Text(movie.title)
                        .font(.headline)
                        .padding(.bottom, 10)
                    
                    Text(movie.releaseDate!)
                    Text(movie.rating)
                    Spacer()
                }
            }
        }
    }
}

//struct MovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRow()
//    }
//}
