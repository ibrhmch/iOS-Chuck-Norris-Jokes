//
//  CategoriesNewView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI

struct CategoriesNewView: View {
    @Binding var backgroundColor: Color
    @Binding var explicitAllowed: Bool
    @ObservedObject var viewModel = CategoriesViewModel()
    @State var searchText: String = ""
    
    var body: some View {
            NavigationStack {
                if viewModel.isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())

                } else {
                    List(searchResults, id: \.self) { item in
                        NavigationLink(destination: JokeNewView(backgroundColor: $backgroundColor, category: .constant(item))) {
                            Text("\(item)")
                        }
                    }
                    .searchable(text: $searchText)
                    .navigationBarTitle("Joke Categories")
                }
            }
            .background(backgroundColor)
            .task {
                await viewModel.getChuckJokesCategories()
            }
    }
    
    var searchResults: [String] {
        if searchText.isEmpty {
            return explicitAllowed ? viewModel.categories : viewModel.categories.filter({$0 != "explicit"})
        } else {
            return explicitAllowed ? viewModel.categories.filter { $0.contains(searchText.lowercased()) } : viewModel.categories.filter { $0.contains(searchText.lowercased()) }.filter({$0 != "explicit"})
        }
    }
}
