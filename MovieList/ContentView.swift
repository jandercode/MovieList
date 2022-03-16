//
//  ContentView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    
    
    //TODO add LoadingView, ErrorView
    var body: some View {
        TabView {
            NavigationView { MovieHomeView() }
            .tabItem { Label("Home", systemImage: "film")}
            
            NavigationView { FavoriteView() }
            .tabItem { Label("Favorites", systemImage: "star")}
            
            NavigationView { MovieSearchView() }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
