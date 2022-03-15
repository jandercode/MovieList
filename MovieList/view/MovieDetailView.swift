//
//  MovieDetailView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct MovieDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    let movieID: Int
    let movieTitle: String
    @ObservedObject var movieDetailState = MovieDetailState()
    
    @ObservedObject var favoriteHandler = FavoriteHandler.shared
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
                
                MovieOverviewView(movie: movie)
                    .padding()
                Text(movieDetailState.movie!.overview).padding()
                Spacer()
                    .toolbar {
                        Button {
                            if !favoriteHandler.inFavorites(movie: movie) {
                                addItem()
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
    
    private func addItem() {
        let newItem = FavoriteMovie(context: viewContext)
        if let movie = movieDetailState.movie {
            newItem.id = Int32(movieID)
            newItem.posterPath = movie.posterPath
            newItem.rating = movie.rating
            newItem.timestamp = Date()
            newItem.title = movieTitle
            newItem.releaseYear = movie.releaseYear
        }
        

        do {
            try viewContext.save()
            print("saved")
            print(newItem)
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
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
