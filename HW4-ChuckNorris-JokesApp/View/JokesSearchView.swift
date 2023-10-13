//
//  JokesSearchView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/28/23.
//

import SwiftUI

struct JokesSearchView: View {
    @ObservedObject var jokeSearchViewModel = JokesSearchViewModel()
    
    var body: some View {
        VStack{
            TextField("Search ...", text: $jokeSearchViewModel.search)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)                
                .onSubmit {
                    Task{
                        await jokeSearchViewModel.getJokes()
                    }
                }
            
            if jokeSearchViewModel.results.total > 0{
                Text("\(jokeSearchViewModel.results.total) jokes found")
            }
            
            List(jokeSearchViewModel.results.result) { joke in
                Text(joke.value)
            }
        }
    }
}
