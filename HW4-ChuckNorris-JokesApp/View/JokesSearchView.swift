//
//  JokesSearchView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/28/23.
//

import SwiftUI

struct JokesSearchView: View {
    @ObservedObject var searchJokes = JokesSearchViewModel()
    @State var search: String = ""
    
    var body: some View {
        VStack{
            TextField("Search ...", text: $searchJokes.search)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal, 10)                
                .onSubmit {
                    Task{
                        await searchJokes.getJokes()
                    }
                }
            
            List(searchJokes.results) { joke in
                Text(joke.value)
            }
        }
    }
}
