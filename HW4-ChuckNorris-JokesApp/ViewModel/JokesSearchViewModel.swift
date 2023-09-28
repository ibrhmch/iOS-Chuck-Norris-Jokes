//
//  JokesSearchViewModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/28/23.
//

import SwiftUI

class JokesSearchViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var results: [JokesResults] = [JokesResults(id: "123", value: "Please Search for a joke")]
    
    func getJokes() async{
        self.results = await getJokesBySearch(search: self.search) ?? [JokesResults(id: "123", value: "Please Search for a joke")]
    }
}
