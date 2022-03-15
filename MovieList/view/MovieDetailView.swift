//
//  MovieDetailView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieDetailView: View {
    
    let movieID: Int
    let movieTitle: String
    @ObservedObject var movieDetailState = MovieDetailState()
    
    @ObservedObject var favoriteHandler = FavoriteHandler()
    //@StateObject private var imageLoader = ImageLoader()
    
    //Load single movie
    var body: some View {
        ScrollView {
            if let movie = movieDetailState.movie {
                
                AsyncImage(url: movie.backdropURL) { phase in
                    switch phase {
                    case .empty:
                        Text(movie.title)
                            .frame(width: 150, height: 220, alignment: .center)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                    case .failure(_):
                        Text(movie.title)
                            .frame(width: 150, height: 220, alignment: .center)
                    @unknown default:
                        Text(movie.title)
                            .frame(width: 150, height: 220, alignment: .center)
                    }
                }
                
                //                    if imageLoader.image != nil {
                //                        Image(uiImage: imageLoader.image!)
                //                            .resizable()
                //                            .aspectRatio(2/3, contentMode: .fit)
                //                            .frame(width: 160, height: 240, alignment: .leading)
                //                    } else {
                //                        Text(movieDetailState.movie!.title)
                //                            .frame(width: 150, height: 220, alignment: .center)
                //                    }
                MovieOverviewView(movie: movie)
                    //.onAppear {imageLoader.loadImage(url: movieDetailState.movie!.posterURL)}
                    .padding()
                Text(movieDetailState.movie!.overview).padding()
                Spacer()
                    .toolbar {
                        Button {
                            if !favoriteHandler.inFavorites(movie: movie) {
                                favoriteHandler.addMovie(movie: movie)
                            } else {
                                favoriteHandler.deleteMovie(movie: movie)
                            }
                            
                            //movieDetailState.movie!.favorite = !movieDetailState.movie!.favorite
                        } label: {
                            Image(systemName: favoriteHandler.inFavorites(movie: movie) ? "star.fill" : "star")
                        }
                    }
            }
        }
        
        .navigationTitle(movieTitle)
        .onAppear {movieDetailState.loadMovie(movieID: movieID)}
    }
}

struct MovieOverviewView: View {
    
    let movie: Movie
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(movie.genreText) - \(movie.releaseYear) - \(movie.duration)").padding(.bottom)
                HStack{
                    if !movie.ratingStars.isEmpty {
                        Text(movie.ratingStars)
                            .foregroundColor(.yellow)
                        Text(movie.rating)
                    } else {
                        Text("No Rating")
                    }
                }
            }
            Spacer()
        }
    }
}

//struct MovieDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MovieDetailView()
//    }
//}
