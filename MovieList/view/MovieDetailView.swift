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
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteMovie.timestamp, ascending: true)],
        animation: .default)
    private var favMovies: FetchedResults<FavoriteMovie>
    
    let movieID: Int
    let movieTitle: String
    @State var favorite = false
    
    @ObservedObject var movieDetailState = MovieDetailState()
    
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
                Divider()
                Spacer()
                    
            }
        }
        .toolbar {
            Button {
                if !inFavorites(id: movieID) {
                    favorite = true
                    addItem()
                } else {
                    favorite = false
                    deleteItems(id: movieID)
                }
            } label: {
                Image(systemName: inFavorites(id: movieID) ? "star.fill" : "star")
            }
        }
        .navigationTitle(movieTitle)
        .onAppear {movieDetailState.loadMovie(movieID: movieID)}
    }
    
    func inFavorites(id: Int) -> Bool {
        for movie in favMovies {
            if id == movie.id {
                return true
            }
        }
        return false
    }
    
    
    private func deleteItems(id: Int) {
        for i in 0..<favMovies.count {
            if id == favMovies[i].id {
                viewContext.delete(favMovies[i])
            }
        }
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    private func addItem() {
        let newItem = FavoriteMovie(context: viewContext)
        if let movie = movieDetailState.movie {
            newItem.id = Int64(movieID)
            newItem.posterPath = movie.posterPath ?? "n/a"
            newItem.rating = movie.rating
            newItem.timestamp = Date()
            newItem.title = movieTitle
            newItem.releaseYear = movie.releaseYear
        }
        do {
            try viewContext.save()
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
        }.frame(maxWidth: .infinity, alignment: .leading)
        Divider().padding([.top, .bottom], -20)
        Text(movie.overview).padding(.top, -30)
    }
}
