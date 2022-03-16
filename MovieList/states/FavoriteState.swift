//
//  FavoriteState.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-16.
//

import SwiftUI

class FavoriteState: ObservableObject {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FavoriteMovie.timestamp, ascending: true)],
        animation: .default)
    var movies: FetchedResults<FavoriteMovie>
    
    func isFavorite(id: Int) -> Bool {
        
        for movie in movies {
            if id == movie.id {
                return true
            }
        }
        return false
    }
    
    func deleteItems(offsets: IndexSet) {
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
