//
//  MovieDetailView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieDetailView: View {
    
    var movie: Movie
    
    //Load single movie
    var body: some View {
        VStack {
            HStack {
                AsyncImage(url: URL(string: movie.posterURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 150, height: 220, alignment: .leading)
                
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .bold()
                        .padding(.bottom, 10)
                    Text(movie.releaseDate ?? "")
                    Text(movie.rating)
                }
                Spacer()
            }
            .padding()
            Text(movie.overview).padding()
            Spacer()
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
