//
//  LoadingView.swift
//  MovieList
//
//  Created by Joakim Andersson on 2022-03-07.
//

import SwiftUI

struct LoadingView: View {
    
    //let isLoading: Bool
    //let error: NSError?
    //let retryAction: (() -> ())?
    
    var body: some View {
        ProgressView()
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
