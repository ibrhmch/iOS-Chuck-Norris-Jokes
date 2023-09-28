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
}

struct JokesResults: Decodable, Identifiable {
    let id: String
    let value: String
}

func getJokesBySearch(search: String = "") async -> [JokesResults]? {
    do {
        let (data, _) = try await URLSession.shared.data(from: URL(string: "https://api.chucknorris.io/jokes/search?query=\(search)")!)
        let jokesResults = try JSONDecoder().decode(JokesResponse.self, from: data)
        return jokesResults.result
    } catch {
        return nil
    }
}
