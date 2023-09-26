//
//  CategoriesNewView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/21/23.
//

import SwiftUI

struct CategoriesNewView: View {
    @Binding var backgroundColor: Color
    @ObservedObject var viewModel = CategoriesViewModel()
    
    var body: some View {
            NavigationStack {
                if viewModel.isLoading{
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())

                } else {
                    List(viewModel.categories, id: \.self) { item in
                        NavigationLink(destination: JokeNewView(backgroundColor: $backgroundColor, category: .constant(item))) {
                            Text("\(item)")
                        }
                    }
                    .navigationBarTitle("Joke Categories")
                }
            }
            .background(backgroundColor)
            .task {
                await viewModel.getChuckJokesCategories()
            }
    }
}
