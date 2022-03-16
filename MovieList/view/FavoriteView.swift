//
//  FavoriteView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-15.
//

import SwiftUI

struct FavoriteView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteMovie.timestamp, ascending: true)],
        animation: .default)
    private var movies: FetchedResults<FavoriteMovie>
    
    var body: some View {
        List {
            ForEach(movies) { movie in
                if let title = movie.title, let id = movie.id, let posterPath = movie.posterPath, let releaseYear = movie.releaseYear, let rating = movie.rating {
                    NavigationLink(destination: MovieDetailView(movieID: Int(id), movieTitle: title)) {
                        HStack {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { phase in
                                switch phase {
                                case .empty:
                                    Text(title)
                                        .frame(width: 200, height: 300, alignment: .center)
                                        .shadow(radius: 4)
                                case .success(let image):
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .cornerRadius(8)
                                        .shadow(radius: 4)
                                        .frame(width: 200, height: 300, alignment: .center)
                                case .failure(_):
                                    Text(title)
                                        .frame(width: 200, height: 300, alignment: .center)
                                                                            
                                @unknown default:
                                    fatalError()
                                }
                            }
                            VStack(alignment: .leading, spacing: 5) {
                                Spacer()
                                Text(title)
                                    .font(.headline)
                                    .padding(.bottom, 10)
                                    .multilineTextAlignment(.leading)
                                Text(releaseYear)
                                Text(rating)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            .foregroundColor(.black)
                            .frame(height: 300, alignment: .center)
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .listStyle(.plain)
        .navigationTitle("Favorites")
    }
    
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { movies[$0] }.forEach(viewContext.delete)
            
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
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
