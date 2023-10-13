//
//  CountryJokeView.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 10/12/23.
//

import SwiftUI

struct CountryJokeView: View {
    @ObservedObject var jokeSearchViewModel = JokesSearchViewModel()
    var countryName: String
    @State var loadingJoke: Bool = true
    
    
    
    var body: some View {
        VStack{
            if loadingJoke {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
            }
            else{
                Text(countryName)
                if jokeSearchViewModel.results.result.count > 0 {
                    List(jokeSearchViewModel.results.result) { joke in
                        Text(joke.value)
                    }
                }else{
                    Text("Try a different country")
                }
            }
        }
        .task{
            jokeSearchViewModel.search = countryName
            await jokeSearchViewModel.getJokes()
            self.loadingJoke = false
        }
    }
}

#Preview {
    CountryJokeView(countryName: "USA")
}
