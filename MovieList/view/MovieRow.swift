//
//  MovieRow.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieRow: View {
    
    let movie: Movie
    @StateObject var imageLoader = ImageLoader()
    
    var body: some View {
        LazyHStack {
            
            
            if imageLoader.image != nil {
                Image(uiImage: imageLoader.image!)
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fit)
                    .frame(width: 150, height: 220, alignment: .leading)
            } else {
                Text(movie.title)
                    .frame(width: 150, height: 220, alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 5) {
                Spacer()
                Text(movie.title)
                    .font(.headline)
                    .padding(.bottom, 10)
                    .frame(width: 100, alignment: .leading)
                    .multilineTextAlignment(.leading)
                Text(movie.releaseYear)
                
                Text(movie.rating)
                Spacer()
            }.foregroundColor(.black)
            
        }.onAppear{imageLoader.loadImage(url: movie.posterURL)}
    }
}

//struct MovieRow_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieRow()
//    }
//}
