//
//  SearchModel.swift
//  HW4-ChuckNorris-JokesApp
//
//  Created by octopus on 9/28/23.
//
import SwiftUI

struct JokesResponse: Decodable {
    let total: Int
    let result: [JokesResults]
    
    init(){
        let tempJoke = JokesResults()
        self.total = 0
        self.result = [tempJoke]
    }
}

struct JokesResults: Decodable, Identifiable {
    let id: String
    let value: String
    
    init(){
        self.id = "123"
        self.value = "Search for a Joke"
    }
}

func getJokesBySearch(search: String = "") async -> JokesResponse? {
    do {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/search?query=\(search)")!)
        let jokesResults = try JSONDecoder().decode(JokesResponse.self, from: data)
        return jokesResults
    } catch {
        return nil
    }
}
