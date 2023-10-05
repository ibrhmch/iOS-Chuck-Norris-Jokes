//
//  JokesSearchViewModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/28/23.
//

import SwiftUI

class JokesSearchViewModel: ObservableObject {
    @Published var search: String = ""
    @Published var results = JokesResponse()
    
    func getJokes() async{
        self.results = await self.getJokesBySearch(search: self.search) ?? JokesResponse()
    }
    
    private func getJokesBySearch(search: String = "") async -> JokesResponse? {
        do {
            let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/search?query=\(search)")!)
            let jokesResults = try JSONDecoder().decode(JokesResponse.self, from: data)
            return jokesResults
        } catch {
            return nil
        }
    }
}
