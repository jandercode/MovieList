//
//  ContentView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-01.
//

import SwiftUI

struct ContentView: View {
    
    //TODO add LoadingView, ErrorView
    var body: some View {
        TabView {
            NavigationView { MovieListView() }
            .tabItem { Label("Home", systemImage: "film")}
            
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
